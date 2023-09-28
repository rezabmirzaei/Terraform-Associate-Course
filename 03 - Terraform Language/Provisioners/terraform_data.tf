# Simplest example I can conceive
# This resource will be used to trigger a local-exec provisioner, without any relation or dependency to any other resource
resource "terraform_data" "greeting_data" {
  provisioner "local-exec" {
    command = "echo Hello from Terraform!"
  }
}

resource "terraform_data" "log_creation_data" {
  # Set the triggers_replace attribute to the ID of the Azure Resource Group "rg_provisioners"
  # Evey time changes occur to the Azure Resource Group, the local-exec provisioner will be triggered
  triggers_replace = [azurerm_resource_group.rg_provisioners.id]
  provisioner "local-exec" {
    # Use a "here document" (<<EOT) to define a multi-line shell command:
    command = <<EOT
      (echo ${azurerm_resource_group.rg_provisioners.name}) > rg_names.txt.new
      type rg_names.txt >> rg_names.txt.new
      move /y rg_names.txt.new rg_names.txt
    EOT
  }
}