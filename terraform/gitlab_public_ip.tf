resource "azurerm_public_ip" "gitlab_public_ip" {
  name                          = "${var.gitlab_server_name}PIP"
  location                      = "${var.location_name}"
  resource_group_name 		    = "${azurerm_resource_group.resource_group.name}"
  domain_name_label             = "${var.gitlab_dns_label}"
  public_ip_address_allocation  = "Static"

  tags {
    environment                 = "${var.environment_name}"
    owner                       = "${var.owner_name}"
    create_method               = "${var.create_method}"
  }
}