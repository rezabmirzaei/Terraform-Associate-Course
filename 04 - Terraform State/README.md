# 04 - Terraform State

Terraform state is a fundamental concept that underpins the management of resources. It serves as a record of the current state of your infrastructure, tracking which resources are deployed and their associated configuration settings. Terraform uses this state information to plan and execute changes to your infrastructure. Understanding how Terraform maintains and interacts with state is essential for working effectively with the tool.

To ensure this crucial state data is stored securely, Terraform utilizes what it calls the **backend**. The backend in Terraform refers to where this state data is stored and how it's accessed. It could be stored locally or remotely (like in AWS S3 or Azure Storage). The backend configuration, in simple terms, tells Terraform where to put and get the state data.

## Backends

Before we dive into examining the state itself, it's crucial to delve a bit deeper into the concept of backends. Understanding how backends work and how to configure them effectively is a necessary prerequisite to harnessing the full power of Terraform in managing your infrastructure.

[TODO]

## terraform.tfstate

The heart of Terraforms state management is the `terraform.tfstate` file. The file is created when you run the `terraform apply` command and subsequently updated every time you do so again.

**terraform.tfstate.backup**

## Terraform State CLI

For a full reference of all commands, please see the [official documentation](https://developer.hashicorp.com/terraform/cli/commands/state).

**terraform state list**: List all resources in the state.

**terraform state show**: Display detailed information about a specific resource in the state.

**terraform state rm**: Remove a resource from the state.

**terraform state mv**: Move a resource to a different address in the state.

**terraform state pull**: Pull the current state and output it in a machine-readable format.

**terraform state push**: Push a previously-pulled state to a remote location.

**terraform state replace-provider**: Replace the provider for a resource in the state.

**terraform apply -replace="RESOURCE_ID"**: Replace a specific resource during the `terraform apply` process. (This is a replacement for the deprecated `terraform taint` command)

**terraform apply -refresh-only**: Force a refresh of specific resources during the `terraform apply` process. (This is a replacement for the deprecated `terraform refresh` command)

## Import Existing Resources

Sometimes, you may have existing resources that you want to manage with Terraform. In such cases, you can use the [terraform import](https://developer.hashicorp.com/terraform/cli/import) command to import these resources into your Terraform state.

---

[< Terraform Language](../03%20-%20Terraform%20Language/) | [Terraform Workspaces >](../05%20-%20Terraform%20Workspaces/)
