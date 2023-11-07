# 04 - Terraform State

Terraform state is a fundamental concept that underpins the management of resources. It serves as a record of the current state of your infrastructure, tracking which resources are deployed and their associated configuration settings. Terraform uses this state information to plan and execute changes to your infrastructure. Understanding how Terraform maintains and interacts with state is essential for working effectively with the tool.

To ensure this crucial state data is stored securely, Terraform utilizes what it calls the **backend**. The backend in Terraform refers to where this state data is stored and how it's accessed. It could be stored locally or remotely (like in AWS S3 or Azure Storage). The backend configuration, in simple terms, tells Terraform where to put and get the state data.

## Backends

A backend defines where Terraform stores its state data files and it plays a vital role in enabling collaboration and remote state management. There are various backend types, each suited for different use cases. The most common backend types include:

- **Local**: Used for local development and debugging.
- **S3**: Ideal for a simple, scalable, and remote storage backend.
- **Azure Blob Storage**: Microsoft Azure's equivalent to S3.
- **Google Cloud Storage**: Google Cloud's option for remote state.
- **Consul**: Suitable for large-scale deployments with HashiCorp Consul.

### Configuring Terraform Backends

Configuring a backend is done in your Terraform configuration file (HCL). Here's an example of how to set up a [remote Azure Blob Storage backend](https://developer.hashicorp.com/terraform/language/settings/backends/azurerm):

```t
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-backend"
    storage_account_name = "sttfbackend"
    container_name       = "conttfbackend"
    key                  = "prod.terraform.tfstate"
  }
}
```

- [Terraform Backend](https://www.terraform.io/docs/language/settings/backends/index.html)

---

## terraform.tfstate

The heart of Terraforms state management is the `terraform.tfstate` file. The file is created when you run the `terraform apply` command and subsequently updated every time you do so again.

**terraform.tfstate.backup**

The `terraform.tfstate.backup` file is a backup of the Terraform state file (`terraform.tfstate`). It's created when Terraform makes changes to the infrastructure and used there to prevent data loss in case something goes wrong during a Terraform run. You can think of it as a safety net to recover the previous state if needed.

## Terraform State Commands

Terraform State Commands enable you to manage the state of your infrastructure, including tasks like checking the current status of your resources, updating or modifying resource attributes, and reordering resources, among others.

For a full reference of all commands, please see the [official documentation](https://developer.hashicorp.com/terraform/cli/commands/state).

To see how these commands work, use the provided configuration files in this chapter ([main.tf](./main.tf), [resources.tf](./resources.tf), and make sure you are logged into Azure as described in chapter [01 - Terraform Basics](../01%20-%20Terraform%20Basics/README.md). Open a terminal in the root folder of this lesson and run:
- `terraform init`
- `terraform apply` (answer yes when prompted to, or run with `-auto-approve`)
- Verify in Azure that the resources are created as expected

**HEADS UP!** Remember to destroy the infrastructure you create _by the end_ of this lesson. Open a terminal in the root folder of this lesson and run:
- `terraform destroy -auto-approve`

### Manage Terraform State

Open a terminal in the root folder of this lesson and run the following commands:

**terraform state list**: List all resources in the state.

**terraform state show RESOURCE_ID**: Display detailed information about a specific resource in the state.

Using our resources in this chapter, to view detailed information about the resource group `azurerm_resource_group.rg_state`:
- `terraform state show azurerm_resource_group.rg_state`

**terraform state rm RESOURCE_ID**: Remove a resource from the state.

Useful when you want to exclude a resource from being managed by Terraform without actually destroying it in your infrastructure. It's a way to clean up the state file and stop tracking a particular resource's state and attributes.

Using our resources in this chapter, to remove the created App Service from our Terraform state, essentially saying we don't want to manage this using Terraform any longer, but we still want to keep the actual resource:
- `terraform state rm azurerm_linux_web_app.app_service`

**terraform state mv**: Move a resource to a different address in the state.

Useful when you want to change how resources are organized or named in your Terraform configuration without recreating them in your infrastructure.

Using our resources in this chapter, to rename the resource group `azurerm_resource_group.rg_state`:
- `terraform state mv azurerm_resource_group.rg_state azurerm_resource_group.new_rg_state`

**terraform state pull**: Pull the current state and output it in a machine-readable format.

**terraform state push**: Push a previously-pulled state to a remote location.

**terraform state replace-provider**: Replace the provider for a resource in the state.

### Changing **state** during **apply**

**terraform apply -replace="RESOURCE_ID"**: Replace a specific resource during the `terraform apply` process (this is a replacement for the deprecated `terraform taint` command).

**terraform apply -refresh-only**: Update the Terraform state and any root module output values to match changes made to remote objects outside of Terraform (this is a replacement for the deprecated `terraform refresh` command).

## Import Existing Resources

Sometimes, you may have existing resources that you want to manage with Terraform. In such cases, you can use the [terraform import](https://developer.hashicorp.com/terraform/cli/import) command to import these resources into your Terraform state.

[TODO]

---

[< Terraform Language](../03%20-%20Terraform%20Language/) | [Terraform Workspaces >](../05%20-%20Terraform%20Workspaces/)
