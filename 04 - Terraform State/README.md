# 04 - Terraform State

Terraform state is a fundamental concept that underpins the management of resources. It serves as a record of the current state of your infrastructure, tracking which resources are deployed and their associated configuration settings. Terraform uses this state information to plan and execute changes to your infrastructure. Understanding how Terraform maintains and interacts with state is essential for working effectively with the tool.

To ensure this crucial state data is stored securely, Terraform utilizes what it calls the **backend**. The backend in Terraform refers to where this state data is stored and how it's accessed. It could be stored locally or remotely (like in AWS S3 or Azure Storage). The backend configuration, in simple terms, tells Terraform where to put and get the state data.

Before we dive into examining the state itself, it's crucial to delve a bit deeper into the concept of backends. Understanding how backends work and how to configure them effectively is a necessary prerequisite to harnessing the full power of Terraform in managing your infrastructure.

[TODO]

---

[< Terraform Language](../03%20-%20Terraform%20Language/) | [Terraform Workspaces >](../05%20-%20Terraform%20Workspaces/)
