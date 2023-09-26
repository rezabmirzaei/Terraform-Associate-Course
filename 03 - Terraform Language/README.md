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

### Resource Syntax and Behavior

Resources in Terraform represent infrastructure components. Let's have a look at the syntax and behavior of resource blocks, including their required and optional arguments.

[TODO]

### Meta-Arguments

Meta-arguments are special configuration options that apply to resource blocks, data blocks, and modules. Some of the most common meta-arguments are:

**depends_on**

The `depends_on` meta-argument allows you to specify explicit dependencies between resources. It ensures that one resource is created or modified only after another resource is successfully created.

- See [depends_on.tf](./Meta%20Arguments/depends_on.tf)

**count**

The `count` meta-argument allows you to create multiple instances of a resource based on a numeric value or a list. It's useful for dynamically generating resources.

- See [count.tf](./Meta%20Arguments/count.tf)

**for_each**

The `for_each` meta-argument is similar to `count` but allows you to create multiple instances of a resource based on a map or a set of strings. It's useful for more complex resource configurations.

- See [for_each.tf](./Meta%20Arguments/for_each.tf)

**lifecycle**

The `lifecycle` meta-argument provides control over resource behavior, including creating, updating, and destroying resources. It can be used for advanced resource management.

- See [lifecycle.tf](./Meta%20Arguments/lifecycle.tf)

### Provisioners

Provisioners are components that allow you to perform actions on resources after they are created or updated. They are used to automate tasks such as configuring, installing software, or running scripts on the resources you manage with Terraform.

**file**

This type copies files or directories from the local machine to the resource after its creation. It's useful for tasks like uploading configuration files.

**remote-exec**

With this provisioner, you can execute commands on the resource itself after it's created. It's often used for tasks like software installation or configuration on the remote machine.

**local-exec**

This provisioner runs commands on the machine where Terraform is executed. It's typically used for tasks that don't involve the managed resource directly but may be required as part of the provisioning process.

**terraform_data (formerly null_resource)**

The null resource is a special type of resource that doesn't correspond to any real infrastructure component. It's used as a trigger to run provisioners when a specific condition is met, even if there's no actual resource to apply them to.

## Data Sources

Data Sources in Terraform allow you to query external info or existing resources for your configuration.

[TODO]

## Expressions

[TODO]

### Functions

Terraform offers built-in functions for manipulating data within your configurations. These functions enable various operations and transformations on values.

### Dynamic Expressions

Dynamic expressions in Terraform allow you to generate values or configurations based on runtime conditions or variables.

### Dynamic Blocks

Dynamic blocks provide a way to conditionally create blocks within resource or module definitions, allowing you to generate complex configurations dynamically.

[TODO]

## Variables

[TODO]

### Input Variables

Input variables allow you to parameterize your Terraform configurations. They provide flexibility and can be set externally or within configuration files.

### Output Values

Output values allow you to expose specific information about your infrastructure for reference or use in other parts of your configuration.

### Local Values

Local values are used to compute intermediate values within a Terraform configuration. They enhance maintainability by avoiding redundancy in expressions.

---

[< Terraform Configuration](../02%20-%20Terraform%20Configuration/) | [Terraform State >](../04%20-%20Terraform%20State/)