# 02 - Terraform Configuration

Effective infrastructure management begins with Terraform Configuration. This section delves into the core components that comprise Terraform's configuration files and their role in creating and maintaining infrastructure.

Terraform Configuration files are the blueprint of your infrastructure, providing a structured approach to defining and provisioning resources. Each file serves a specific purpose in this orchestration process. The following list represents a selection of key configuration elements. Throughout the course we'll delve into each of them, gaining a more comprehensive understanding of their significance and usage:

- **`main.tf`:**
  - The primary configuration file where you articulate your resource specifications and configurations. This is where you lay the foundation for your infrastructure by specifying what resources you want to create or manage.

- **`outputs.tf`:**
  - Define output values here that can be queried post-provisioning. Outputs provide a means to capture essential information about the resources Terraform creates or manages, facilitating further actions, decision-making, or information sharing.

- **`variables.tf`:**
  - This file is dedicated to declaring input variables, accompanied by their types and descriptions. Input variables lend flexibility and reusability to your Terraform configurations, allowing you to tailor resources without modifying the core configuration.

- **`terraform.tfvars`:**
  - Assign values to input variables via this file, facilitating parameterization of your configurations. It isolates variable values from the core configuration, streamlining customization while preserving configuration integrity.

- **`terraform.tfstate`:**
  - Maintain awareness of your infrastructure's current state. Terraform relies on this state file to comprehend the existing state of your resources, compare it with the desired state in your configuration, and execute necessary actions to synchronize the two.

- **`terraform.tfstate.backup`:**
  - An automatically generated backup of the state file. This serves as an additional layer of security, allowing you to restore your infrastructure's previous state in case of accidental loss or corruption of the primary state file.

- **`terraform.lock.hcl`:**
  - A lock file used to record and pin precise versions of provider plugins in your configuration. This ensures stability and predictability by preventing unexpected changes stemming from provider updates.

Mastering Terraform Configuration is pivotal to proficiently architecting and managing infrastructure using Terraform. These configuration files serve as your foundation in the world of Infrastructure as Code with Terraform. They allow you to define, tailor, and sustain your infrastructure resources with precision and consistency.

## DEMO - Configuration files and variables

Let's walk through a simple example to demonstrate Terraform's configuration files, with a special focus on how variables are handled. We will use the [following configuration (main.tf)](./main.tf), supported by [variables.tf](./variables.tf), and a provided [outputs.tf](./outputs.tf).

Assuming you have followed the setup as descibed in the [Terraform Basics section](../01%20-%20Terraform%20Basics/) (including authentication for Azure), in the root folder of this section, open a terminal and do the following:

- **Initialize Terraform:**
  - Run `terraform init` to initialize the project.
  - Verify that the `.terraform.lock.hcl` file is created as a result of the initialization.

- **Plan the execution:**
  - Run `terraform plan`

Terraform will by default read the values for the configured variables from the `variables.tf` file. Notice the name and location of the resource group. These will be the values defined in `variables.tf`.

At the end of the plan output, notice the variable named "resource_group_id". This output variable is defined in [outputs.tf](./outputs.tf) and will hold the ID of the Azure resource group once it has been created (after `terraform apply`, see next step).

- **Apply the plan:**
  - Run `terraform apply` (approve by typing 'yes')
  - Verify that the `terraform.tfstate` and `terraform.tfstate.backup` files are created as a result of applying the plan.
  - Run `terraform output resource_group_id` to se the ID of the newly created resource.

### More on variables

You can provide values for variables in multiple ways (each step taking presedence over the previous):
1. By specifying default values in the "variables.tf" file (as we've seen already).
2. By providing values in a "terraform.tfvars" file.
3. By creating custom files and using the "-var-file" flag when running Terraform commands.
4. By passing values using the "-var" flag when running Terraform commands.

**Create a `terraform.tfvars` file**

In the same directory as the `main.tf`, create a `terraform.tfvars` file:

```t
resource_group_name = "rg-terraform-config-tfvars"
location            = "West Europe"

```

Terraform will by default read the values for the configured variables from the file. To use it, simply run:
- `terraform plan`

Notice the name and location of the resources group. The values provided by the original `variables.tf` are overwritten with the ones from `terraform.tfvars`.

**Use the `-var-file` and `-var` flags**

You can create a custom variable file with variable name/value pairs and use the `-var-file` flag to pass those values to Terraform. In the same directory as the `main.tf` file, create a `custom-variables.tfvars` file:

```t
resource_group_name = "rg-terraform-config-custom-tfvars"
location            = "North Europe"
```

Using this file, run:
- `terraform plan -var-file=custom-variables.tfvars`

Notice the name and location of the resources group. The values provided by the original `variables.tf` and `terraform.tfvars` are overwritten by the ones provided by the custom file.

You can also pass values for individual variables using the `-var` flag followed by the variable name and its value. For example, specify a value for the `resource_group_name` variable:
-  `terraform plan -var="resource_group_name=my-var-flag-rg-name"`

Notice the name the resources group. The values provided by the original `variables.tf` and `terraform.tfvars` are overwritten, as would any value provided by a custom file if that had been provided using the `-var-file` flag.

We will explore the concept of variables more in the next chapter.

---

[< Terraform Basics](../01%20-%20Terraform%20Basics/) | [Terraform Language >](../03%20-%20Terraform%20Language/)