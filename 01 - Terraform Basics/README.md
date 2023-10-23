# 01 - Terraform Basics

Terraform is an open-source infrastructure as code (IaC) tool developed by HashiCorp. It is designed to be cloud-agnostic, which means you can use it to manage resources on various cloud providers, such as AWS, Azure, Google Cloud, and more. With Terraform, you can define your infrastructure in code, making it reproducible, version-controlled, and easily manageable.

## Terraform HashiCorp Configuration Language (HCL)

Before diving into Terraform, let's have a brief look at the core concepts of its language. Terraform uses a domain-specific language called **HashiCorp Configuration Language (HCL)** for writing infrastructure as code (IaC). HCL uses a **declarative** syntax and is designed to be human-readable and easy to understand. Below is a simple example of a Terraform configuration written in HCL:

```t
# Configuration block defines the required providers and versions
terraform {
# ... Omitted
}

# ... Omitted

# Resource block defines infrastructure resource to provision
resource "azurerm_resource_group" "rg_basics" {
  # Configuration settings for the resource to provision
  name     = "rg-terraform-basics"
  location = "Norway East"
}
```

**Terraform block:** Core building block used to configure global settings and behavior for your Terraform project (typically only one terraform block in a project). It usually appears at the top of your configuration file and defines things like the required Terraform version, backend configuration, and any provider configurations.

**Resource Block:** The fundamental building block in Terraform HCL. Resource blocks declare the infrastructure resources you want to create or manage. In this case, it's defining an Azure Resource Group, given by the first parmater "azurerm_resource_group". The "rg-tf-basics" is a user defined label or identifier for the resource block, used to uniquely reference this resource block elsewhere in your Terraform configuration.

**Configuration Settings:** Inside the resource block, you provide configuration settings for the resource you're creating. In this case, it's setting the name of the Azure Resource Group to "rg-terraform-basics" and location where the Azure Resource Group will be created.

As we progress through this course we'll explore all of these concepts (and several others) in greater detail, but for now here's a brief overview:

- **Declarative Syntax:**
  - Terraform allows you to declare the desired state of your infrastructure. Instead of specifying step-by-step instructions for provisioning resources, you define what resources should exist and their configurations.

- **Providers:**
  - Providers are plugins that enable Terraform to interact with specific cloud providers, services, or platforms. Each provider is responsible for translating Terraform configurations into API calls for resource provisioning and management.

- **Resources:**
  - Resources are the building blocks of your infrastructure. These can be virtual machines, databases, networks, and more. Terraform providers (e.g., Azure, AWS) offer a wide range of resource types that you can manage.

- **Variables:**
  - Variables in Terraform allow you to parameterize your configurations. This flexibility enables you to reuse and customize your infrastructure code for different environments or use cases.

- **Outputs:**
  - Outputs let you expose information from your infrastructure for reference or use in other parts of your configuration.

- **Provisioners:**
  - Provisioners are a set of tools for performing actions on resources either before or after resource creation. They enable you to customize and configure resources as needed.

- **Modules:**
  - Modules are reusable components that encapsulate sets of resources and their configurations. They promote code organization and modularity in your Terraform projects.

- **Workspaces:**
  - Terraform workspaces offer a means to effectively manage various environments or configurations within a single Terraform project, such as for development, testing, and production purposes.

## Terraform Lifecycle

Terraform follows a specific lifecycle when managing infrastructure. Understanding this lifecycle is crucial for effective IaC management.

- **Initialization ([terraform init](https://developer.hashicorp.com/terraform/cli/commands/init)):**
  - When you begin working on a new Terraform project, you initiate it using the `terraform init` command.
  - This command initializes the working directory, downloads the necessary providers (plugins), and prepares the project for further configuration and execution.
  
- **Planning ([terraform plan](https://developer.hashicorp.com/terraform/cli/commands/plan)):**
  - The `terraform plan` command is used to create an execution plan.
  - It analyzes your configuration files and current infrastructure state, then generates a plan detailing what changes will be made when applied.
  
- **Applying Changes ([terraform apply](https://developer.hashicorp.com/terraform/cli/commands/apply)):**
  - To enact the changes described in the plan, you use the `terraform apply` command.
  - This step provisions or modifies infrastructure resources based on your configuration.
  
- **Destroying Resources ([terraform destroy](https://developer.hashicorp.com/terraform/cli/commands/destroy)):**
  - When you want to tear down resources, the `terraform destroy` command is used.
  - This reverses the changes made by `terraform apply`, effectively removing the resources.

## Installation (CLI) and Configuration (setup/authentication to Azure)

Before you can use Terraform, you need to install the Terraform CLI and configure it to work with your cloud provider. Here's how to get started:

**Installing Terraform CLI:**

Installation instructions may vary depending on your operating system. Go to [Terraform website](https://www.terraform.io/downloads.html) to download the appropriate package. Follow the instructions for your OS and ensure the Terraform executable is available on your path.

**Configuring Authentication for Azure:**

To interact with Azure, you need to set up authentication. This typically involves [creating a service principal](https://learn.microsoft.com/en-us/cli/azure/azure-cli-sp-tutorial-1):

- Open a terminal and type:
  - ``az login``
- Follow the instructions and login into your active Azure account. Remember your **subscription id** from the login output.
- In the terminal type:
  - ``az account set --subscription <YOUR_SUBSCRIPTION_ID>``
- Create a service principal. In the terminal type:
  - ``az ad sp create-for-rbac -n "<YOUR_SPN_NAME>" --role="Contributor" --scopes="/subscriptions/<YOUR_SUBSCRIPTION_ID>"``

__Heads up!__ Make sure to:
1. __Save__ the __password__ generated for the service principal. It is only visible on the output after creation. 
2. Give the service principal privileges to create resources in your Azure subscription (e.g. ``--role="Contributor"``).

Finally, log out of Azure (``az logout``) to avoid any mishaps using your own login credentials.

Terraform needs a way to communicate with your Azure account/subscription. For this, we utilize the service principal and account/subscription from the previous steps to set the following environment variables:

```t
ARM_CLIENT_ID = "<SPN_APPID_VALUE>"
ARM_CLIENT_SECRET = "<SPN_CLIENT_SECRET_VALUE>"
ARM_SUBSCRIPTION_ID = "<YOUR_SUBSCRIPTION_ID>"
ARM_TENANT_ID = "<YOUR_TENANT_ID>"
```
You can find your __<SPN_APPID_VALUE>__ in the Azure portal, under _Azure Active Directory_ > _App registrations_ > _Application (client) ID_.

The __<SPN_CLIENT_SECRET_VALUE>__ is the __password__ generated for the service principle. It is only visible on the output after creation. If you have lost it, you will need to [reset it](https://learn.microsoft.com/en-us/cli/azure/ad/sp/credential?view=azure-cli-latest#az-ad-sp-credential-reset). 

Read more on [Authenticate Terraform to Azure](https://learn.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash).

## Basic Commands: init, plan, apply, destroy

Let's walk through a basic example to demonstrate Terraform's core commands using the [following configuration (main.tf)](./main.tf). We will cover the different concepts of the workflow in more depth as we proceed through the course. **Copy the provided configuration file to a folder on your own computer, or fork/clone this project.**

Assuming you have followed the setup as descibed so far (including authentication for Azure), open a terminal in the folder where the configuration file (main.tf) is and perform these steps:

- **Initialization (terraform init):**
  - Run `terraform init` to initialize the project.
  - Verify the initialization. In the same directory where you ran the command, ensure you have a directory `.terraform/providers`. In this directory, ensure you have the provider specified in the configuration (e.g. `terraform-provider-azurerm_[SOME_VERSION]`).
  
- **Planning (terraform plan):**
  - Run `terraform plan` to create a plan.
  - Examine the plan output to understand the changes Terraform will make.
  
- **Applying changes (terraform apply):**
  - Apply the plan with `terraform apply`.
  - Confirm the changes when prompted (type `yes`).
  - Validate the changes by logging into you Azure portal and seeing the resources created as configured.

- **Destroying resources/cleanup (terraform destroy):**
  - To destroy the resources, run `terraform destroy`.
  - Review and confirm the destruction (log into Azure and make sure it's all gone).

## Additional Commands: validate, fmt

- **Validation ([terraform validate](https://developer.hashicorp.com/terraform/cli/commands/validate)):**
  - Edit the [main.tf](./main.tf) file and make it invalid, e.g. by removing the required property `name` from the `resource` block.
  - Run `terraform validate` to check the configuration for syntax errors and other issues.
  - Notice the output marks the configuration as invalid.
  - Revert the changes you made to the file and run `terraform validate` again to verify that everything is ok.

- **Formatting ([terraform fmt](https://developer.hashicorp.com/terraform/cli/commands/fmt)):**
  - Edit the [main.tf](./main.tf) file and mix up the formatting, e.g. by adding extra whitespaces before `name` property in the `resource` block.
  - Run `terraform fmt` to automatically format your configuration files in a consistent style.
  - Verify that the file is reformatted back to its original state. 

## Terraform Cloud (short intro, more at end of course)

Terraform Cloud is a powerful platform for managing Terraform projects at scale. While we'll dive deeper into its features later in the course, here's a brief introduction:

- **Introduction to Terraform Cloud:**
  - Terraform Cloud is a hosted service by HashiCorp that offers remote state management, collaboration tools, and workspace automation.
  - It enables teams to work together on Terraform projects more effectively.

In the later part of this course, we'll explore Terraform Cloud's advanced features and how it can enhance your Terraform workflow.

---

[< Introduction](../README.md) | [Terraform Configuration >](../02%20-%20Terraform%20Configuration/)