# 03 - Terraform Language

Terraform uses a declarative language called [HashiCorp Configuration Language (HCL)](https://developer.hashicorp.com/terraform/language/syntax/configuration) for provisioning and configuring resources in a cloud or on-premises environment. It supports a wide range of concepts that enable you to efficiently manage your infrastructure such as core configuration blocks for version compatibility, provider settings and connection configuration, resource management, variables, outputs, modularization through modules, secrets handling and much more.

## Core Configuration Blocks

Let's explore the core configuration blocks of Terraform, used to define how your infrastructure should be provisioned and managed. See [main.tf](./main.tf) for examples of these concepts.

### Terraform Block

The `terraform` block is the root block in a Terraform configuration file. It defines the required provider configuration and specifies the minimum Terraform version for compatibility.

### Provider Block

The `provider` block is used to configure a specific provider, such as AWS or Azure. It contains provider-specific settings like authentication credentials and region (depending on the provider).

Information about the various providers and supported configuration for each can be found on the [Terraform Registry for Providers](https://registry.terraform.io/browse/providers).

### Multiple Providers

In some cases, you might need to work with multiple instances of the same provider. This could be for managing resources across different regions, subscriptions, environments, or simply configuring various resources based on certain requirements. You can do this by specifying separate provider configurations with appropriate `aliases` for each instance. These aliases allow you to clearly differentiate and manage the various provider settings. An example of configuring multiple providers and resources can be found in the provided [main.tf](./Core%20Configuration/main.tf) file.

**Reminder: `terraform.lock.hcl`** - This file (also referred to as the _Providers Dependency Lock File_) is automatically created by Terraform when you initialize your configuration. It is used to record the versions of provider plugins used in a Terraform configuration. It helps ensure reproducibility and stability in your infrastructure deployments.

### Versions

In your Terraform configuration, you can specify the minimum required Terraform version using the `required_version` attribute in the `terraform` block. This sets a baseline for the Terraform version needed to work with your configuration.

For providers, you define version constraints in the `required_providers` block within the `terraform` block. You specify the provider's source (usually in the format "namespace/provider") and a version constraint. Terraform will attempt to download and use a provider version that meets this constraint.

The version constraint format typically includes operators like `>=`, `<=`, `~>`, and others to define which provider versions are acceptable. For example, `version = "~> 2.0"` means any provider version equal to or greater than 2.0 but less than 3.0 is acceptable. Different ways to define such constraints are (from the [official documentation](https://developer.hashicorp.com/terraform/language/expressions/version-constraints)):

- `=` (or no operator): Allows only one exact version number. Cannot be combined with other conditions.

- `!=`: Excludes an exact version number.

- `>`, `>=`, `<`, `<=`: Comparisons against a specified version, allowing versions for which the comparison is true. "Greater-than" requests newer versions, and "less-than" requests older versions.

- `~>`: Allows only the rightmost version component to increment. For example, to allow new patch releases within a specific minor release, use the full version number: `~> 1.0.4` will allow the installation of `1.0.5` and `1.0.10` but not `1.1.0`."

## Terraform Resources

### Resource Syntax

Resources in Terraform represent infrastructure components. We had a brief look in chapter [01 Terraform Basics](./../01%20-%20Terraform%20Basics/) at how resources are defined, using the `resource` block:

```t
# Resource block defines infrastructure resource to provision
resource "resource_type" "resource_identifier" {
  # Configuration settings for the resource to provision
  key = "value"
}
```

- `resource`: This keyword indicates that you are defining an infrastructure resource.
- `"resource_type"`: This is the type of the resource you are defining. You would replace "resource_type" with the actual type of resource you want to create, such as "aws_instance" or "azurerm_virtual_machine."
- `"resource_identifier"`: This is a unique name or identifier for this specific resource block. It helps you refer to this resource block elsewhere in your configuration.
- `key = "value"`: Within the resource block, you define configuration settings for the specific resource. In this example, `key` is a placeholder for an actual configuration setting, and `"value"` is a placeholder for the value you want to assign to that setting. You would replace `key` and `"value"` with actual configuration settings and values relevant to the resource type you are defining.

We've already created Azure Resource Groups ("azurerm_resource_group") using the definition explained above, as seen in [main.tf](../01%20-%20Terraform%20Basics/main.tf), and we'll cover other examples of resources going forward in the course.

### Variables (Revisited)

We had a look at variables in chapter [02 - Terraform Configuration](./../02%20-%20Terraform%20Configuration/). Before moving ahead, here is a quick recap and an introduction to "Local Values" (`locals`). A full example can be found in the following [main.tf](./Variables%20Revisited/main.tf).

**Input Variables**

[Input variables](https://developer.hashicorp.com/terraform/language/values/variables) allow you to parameterize your Terraform configurations. They provide flexibility and can be set externally or within configuration files. To declare a variable, use the `variable` block in your Terraform code:

```t
variable "location" {
  type    = string
  default = "East US"
}
```

The variable can be referenced in your configuration using the `var` keyword:

```t
resource "azurerm_virtual_network" "vnet_example" {
  # ... Omitted
  location = var.location
}
```

See chapter [02 - Terraform Configuration](./../02%20-%20Terraform%20Configuration#demo-configuration-files-and-variables) on how to set and pass values for input variables.

**Output Values**

[Output values](https://developer.hashicorp.com/terraform/language/values/outputs) allow you to expose specific information about your infrastructure for reference or use in other parts of your configuration. To declare an output value, use the `output` block in your Terraform code:

```t
output "vnet_id" {
  value = azurerm_virtual_network.vnet_example.id
}
```

You can then retrieve this output value using the `terraform output` command, after a successful `terraform apply`. It's important to note that certain values, like the `id` in this example, are not known until the associated resource is actually created.

**Local Values**

[Local values](https://developer.hashicorp.com/terraform/language/values/locals) are used to compute intermediate values within a Terraform configuration. They enhance maintainability by avoiding redundancy in expressions. To declare an local values, use the `locals` block in your Terraform code:

```t
locals {
  address_space = "10.0.0.0/16"
}
```

You can use these local values in your resources or other expressions within your configuration using the `local` keyword:

```t
resource "azurerm_virtual_network" "vnet_example" {
  # ... Omitted
  address_space = [local.address_space]
}
```

### Meta-Arguments

Meta-arguments are special configuration options that apply to resource blocks, data blocks, and modules. Some of the most common meta-arguments are:

**depends_on**

The [depends_on](https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on) meta-argument allows you to specify explicit dependencies between resources. It ensures that one resource is created or modified only after another resource is successfully created.

- See [depends_on.tf](./Meta%20Arguments/depends_on.tf)

**count**

The [count](https://developer.hashicorp.com/terraform/language/meta-arguments/count) meta-argument allows you to create multiple instances of a resource based on a numeric value or a list. It's useful for dynamically generating resources.

- See [count.tf](./Meta%20Arguments/count.tf)

**for_each**

The [for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each) meta-argument is similar to `count` but allows you to create multiple instances of a resource based on a map or a set of strings. It's useful for more complex resource configurations.

- See [for_each.tf](./Meta%20Arguments/for_each.tf)

**lifecycle**

The [lifecycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle) meta-argument provides control over resource behavior, including creating, updating, and destroying resources. It can be used for advanced resource management.

- See [lifecycle.tf](./Meta%20Arguments/lifecycle.tf)

### Provisioners

Provisioners are components that allow you to perform actions on resources after they are created or updated. They are used to automate tasks such as configuring, installing software, or running scripts on the resources you manage with Terraform.

**file**

The [file provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/file) copies files or directories from the local machine to the resource after its creation. It's useful for tasks like uploading configuration files.

- See [file.tf](./Provisioners/file.tf)

**remote-exec**

With the [remote-exec provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec), you can execute commands on the resource itself after it's created. It's often used for tasks like software installation or configuration on the remote machine.

- See [remote-exec.tf](./Provisioners/remote-exec.tf)

**local-exec**

The [local-exec provisioner](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec) runs commands on the machine where Terraform is executed. It's typically used for tasks that don't involve the managed resource directly but may be required as part of the provisioning process.

- See [local-exec.tf](./Provisioners/local-exec.tf)

**terraform_data (formerly null_resource)**

The [terraform_data provisioner](https://developer.hashicorp.com/terraform/language/resources/terraform-data) is a special type of resource that doesn't correspond to any real infrastructure component. It's used as a trigger to run provisioners when a specific condition is met, even if there's no actual resource to apply them to.

- See [terraform_data.tf](./Provisioners/terraform_data.tf)

## Expressions

[TODO]

### Functions

Terraform offers built-in functions for manipulating data within your configurations. These functions enable various operations and transformations on values.

### Dynamic Expressions

Dynamic expressions in Terraform allow you to generate values or configurations based on runtime conditions or variables.

### Dynamic Blocks

[Dynamic blocks](https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks) in Terraform that enable you to dynamically generate and customize blocks of configuration within your resource or module definitions. Instead of having a fixed number of statically defined blocks, you can use dynamic blocks to create blocks conditionally or iteratively. You can add dynamic blocks to your resource or module using the `dynamic` keyword:

```t
dynamic "subnet" {
  for_each = var.subnets
  content {
    name           = subnet.key
    address_prefix = subnet.value
  }
}
```

In this example, the `for_each` argument iterates over a map variable `var.subnets`, and for each entry in the map, it generates a dynamic block with custom configurations (setting the subnet "name" and "address_prefix").

- See [dynamic.tf](./Functions/dynamic.tf)

## Data Sources

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources) in Terraform allow you to query and retrieve information from external sources or existing resources, such as configuration values or resource attributes, to be used within your Terraform configurations. They enable you to incorporate real-world data or properties of pre-existing infrastructure into your Terraform code. Data sources are declared using a `data` block:

```t
data "azurerm_resources" "dev_web_data" {
  resource_group_name = "rg-terraform-data"
  required_tags = {
    environment = "Dev"
    role        = "Webserver"
  }
}
```

The example above queries Azure and retrieves resources that meet the specific tag criteria. The data source, `azurerm_resources` (identified as `dev_web_data`), contacts Azure to search for resources within the "rg-terraform-data" resource group, filters the resources based on the specified tags, and returns a list of all Azure resources that match the tag criteria.

It's important to note that different data sources may have different required and optional parameters. To use data sources effectively, consult the [Terraform documentation](https://developer.hashicorp.com/terraform/language/data-sources) for each specific data source to understand its configuration options and parameters.

- See [data.tf](./Data%20Sources/data.tf)

---

[< Terraform Configuration](../02%20-%20Terraform%20Configuration/) | [Terraform State >](../04%20-%20Terraform%20State/)