# Create a resource group
resource "azurerm_resource_group" "resource_group" {
  name            = "${var.resource_group_name}"
  location        = "${var.location_name}"

  tags {
    environment   = "${var.environment_name}"
    owner         = "${var.owner_name}"
    create_method = "${var.create_method}"
  }

}