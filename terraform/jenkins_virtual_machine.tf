# Create Jenkins virtual machine
resource "azurerm_virtual_machine" "jenkins_server" {
  name                  = "${var.jenkins_server_name}VM"
  location 			    = "${var.location_name}"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  network_interface_ids = ["${azurerm_network_interface.jenkins_vnic.id}"]
  vm_size               = "Standard_B2s"

  storage_os_disk {
    name              = "${var.jenkins_server_name}Disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  provisioner "file" {
    source      = "../bootstrap/${var.jenkins_bootstrap_script}"
    destination = "/tmp/${var.jenkins_bootstrap_script}"

    connection {
      type        = "ssh"
      agent       = false
      host        = "${azurerm_public_ip.jenkins_public_ip.ip_address}"
      private_key = "${file("~/.ssh/id_rsa")}"
      user        = "${var.admin_username}"
    }

  }

  provisioner "file" {
    source      = "../bootstrap/jenkins/init.groovy"
    destination = "/tmp/init.groovy"

    connection {
      type        = "ssh"
      agent       = false
      host        = "${azurerm_public_ip.jenkins_public_ip.ip_address}"
      private_key = "${file("~/.ssh/id_rsa")}"
      user        = "${var.admin_username}"
    }

  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/${var.jenkins_bootstrap_script} /opt/${var.jenkins_bootstrap_script}",
      "sudo chmod +x /opt/${var.jenkins_bootstrap_script}",
      "sudo /opt/${var.jenkins_bootstrap_script}"
    ]

    connection {
      type        = "ssh"
      agent       = false
      host        = "${azurerm_public_ip.jenkins_public_ip.ip_address}"
      private_key = "${file("~/.ssh/id_rsa")}"
      user        = "${var.admin_username}"
    }

  }

  os_profile {
    computer_name  = "${var.jenkins_server_name}VM"
    admin_username = "${var.admin_username}"
    admin_password = "${var.admin_password}"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/id_rsa.pub")}"
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