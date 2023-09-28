# See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account
resource "azurerm_storage_account" "st_local_exec_provisioner" {
  name                     = "sttlocalexecprovisioner"
  resource_group_name      = azurerm_resource_group.rg_provisioners.name
  location                 = azurerm_resource_group.rg_provisioners.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# "local machine" refers to the machine running the current configuration
resource "azurerm_storage_container" "cont_local_exec_provisioner" {
  name                  = "conttflocalexecprovisioner"
  storage_account_name  = azurerm_storage_account.st_local_exec_provisioner.name
  container_access_type = "container"

  # https://sttlocalexecprovisioner.blob.core.windows.net/conttflocalexecprovisioner
  provisioner "local-exec" {
    command = "az storage blob upload --account-name ${azurerm_storage_account.st_local_exec_provisioner.name} --container-name ${azurerm_storage_container.cont_local_exec_provisioner.name} --name hello.txt --file hello.txt --auth-mode login"
  }

}

# For reference only; this can be done using a (deprecated) null_resource or terraform_data block
# resource "null_resource" "upload_file" {
#   triggers = {
#     storage_account_id = azurerm_storage_account.st_file_provisioner.id
#   }

#   provisioner "local-exec" {
#     command = "azcopy copy ./hello.txt https://${azurerm_storage_account.st_local_exec_provisioner.name}.blob.core.windows.net/${azurerm_storage_container.cont_local_exec_provisioner.name}/file.txt"
#   }
# }
