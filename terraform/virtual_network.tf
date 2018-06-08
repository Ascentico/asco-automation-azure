# Create a virtual network
resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.vnet_name}"
  address_space       = ["${var.vnet_address_space}"]
  location            = "${var.location_name}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  tags {
    environment   = "${var.environment_name}"
    owner         = "${var.owner_name}"
    create_method = "${var.create_method}"
  }

}