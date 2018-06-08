# Create subnet
resource "azurerm_subnet" "subnet" {
  name                  = "${var.subnet_name}"
  resource_group_name   = "${azurerm_resource_group.resource_group.name}"
  virtual_network_name  = "${azurerm_virtual_network.virtual_network.name}"
  address_prefix         = "${var.vnet_address_space}"
}