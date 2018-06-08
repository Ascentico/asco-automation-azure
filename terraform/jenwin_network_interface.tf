# Create the network interfaces
resource "azurerm_network_interface" "jenwin_vnic" {

  name                      = "${var.jenwin_server_name}NIC"
  location 			        = "${var.location_name}"
  resource_group_name       = "${azurerm_resource_group.resource_group.name}"
  network_security_group_id = "${azurerm_network_security_group.network_security_group.id}"

  ip_configuration {
    name                          = "${var.jenwin_server_name}VMconfiguration"
    subnet_id                     = "${azurerm_subnet.subnet.id}"
    private_ip_address_allocation = "Static"
    public_ip_address_id          = "${azurerm_public_ip.jenwin_public_ip.id}"
    private_ip_address 			  = "${var.jenwin_private_ip_address}"

  }

  tags {
    environment   = "${var.environment_name}"
    owner         = "${var.owner_name}"
    create_method = "${var.create_method}"
  }
}