
# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

The Root Module Structure is as follows:

```
Project_Root
|
├── main.tf             # contains everything else
├── providers.tf        # defined required providers and their configuration
├── outputs.tf          # stores our outputs
├── variables.tf        # stores the structure of input variables
├── terraform.tfvars    # the date of varialbes we want to load into our terraform project
└── README.md           # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)
