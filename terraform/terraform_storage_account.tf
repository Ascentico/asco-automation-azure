# Create storage account for Terraform state
resource "azurerm_storage_account" "terraform_storage_account" {
  name                        = "${var.terraform_storage_account_name}"
  resource_group_name         = "${azurerm_resource_group.resource_group.name}"
  location 					  = "${var.location_name}"
  account_tier                = "Standard"
  account_replication_type    = "LRS"
  enable_blob_encryption   = "true"
  enable_file_encryption   = "true"

  tags {
    environment   = "${var.environment_name}"
    owner         = "${var.owner_name}"
    create_method = "${var.create_method}"
  }
}