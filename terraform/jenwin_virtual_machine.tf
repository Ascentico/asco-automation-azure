# Create Jenkins Windows Build Server
resource "azurerm_virtual_machine" "jenwin_server" {
  name                  = "${var.jenwin_server_name}VM"
  location 			    = "${var.location_name}"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids = ["${azurerm_network_interface.jenwin_vnic.id}"]
  vm_size               = "Standard_B2s"

  storage_os_disk {
    name              = "${var.jenwin_server_name}Disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  os_profile {
    computer_name = "${var.jenwin_server_name}VM"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
    custom_data = "${base64encode("Param($RemoteHostName = \"${null_resource.intermediates.triggers.full_vm_dns_name}\", $ComputerName = \"${var.jenwin_server_name}VM\", $WinRmPort = ${var.winrm_secure_port}) ${file("../bootstrap/bootstrap-winrm.ps1")}")}"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent = true

    additional_unattend_config {
      pass = "oobeSystem"
      component = "Microsoft-Windows-Shell-Setup"
      setting_name = "AutoLogon"
      content = "<AutoLogon><Password><Value>${var.admin_password}</Value></Password><Enabled>true</Enabled><LogonCount>1</LogonCount><Username>${var.admin_username}</Username></AutoLogon>"
    }

    #Unattend config is to enable basic auth in WinRM, required for the provisioner stage.
    additional_unattend_config {
      pass = "oobeSystem"
      component = "Microsoft-Windows-Shell-Setup"
      setting_name = "FirstLogonCommands"
      content = "${file("../bootstrap/${var.windows_first_logon_command}")}"
    }
  }

  provisioner "file" {
    source      = "../bootstrap/${var.jenwin_bootstrap_script}"
    destination = "C:\\${var.jenwin_bootstrap_script}"
    connection {
      type = "winrm"
      https = true
      insecure = true
      user = "${var.admin_username}"
      password = "${var.admin_password}"
      host = "${null_resource.intermediates.triggers.full_vm_dns_name}"
      port = "${var.winrm_secure_port}"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "powershell.exe -sta -ExecutionPolicy Unrestricted -file C:\\${var.jenwin_bootstrap_script}",
    ]
    connection {
      type = "winrm"
      https = true
      insecure = true
      user = "${var.admin_username}"
      password = "${var.admin_password}"
      host = "${null_resource.intermediates.triggers.full_vm_dns_name}"
      port = "${var.winrm_secure_port}"
    }
  }

  boot_diagnostics {
    enabled     = "true"
    storage_uri = "${azurerm_storage_account.diag_storage_account.primary_blob_endpoint}"
  }

  tags {
    environment   = "${var.environment_name}"
    owner         = "${var.owner_name}"
    create_method = "${var.create_method}"
  }
}