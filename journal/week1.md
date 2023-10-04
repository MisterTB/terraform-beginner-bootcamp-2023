
# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags

[How to Delete Local and Remote Tags](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

Deleting a local tag

```sh
git tag -d <tag_name>
```

Deleting a remote tag

```sh
git push --delete origin tagname
```

To checkout the commit that you want to re-tag, grab the SHA from GitHub history.

```sh
git checkout <SHA>
git tag M.M.P
git push --tags
git checkout main
```
* M.M.P = Major.Minor.Patch

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
Created tree structure at https://tree.nathanfriend.io/ .

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In Terraform two kinds of variables can be set:

- Environment Variables - These are variables you would set in the BASH terminal. eg. AWS credentials
- Terraform Variables - These are variables you would set up in the tfvars file.

Terraform Cloud variables can be set to sensitive so they are hidden in the UI.

### Loading Terraform Variables

[Terraform Variables](https://developer.hashicorp.com/terraform/language/values/variables)

#### terraform.tvfars

This is the default file to load terraform variables in bulk.

#### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file.
eg. `terraform -var user_uuid="xxx-xxx-xxx-xxx"`

#### var-file flag
Your input variables can be placed in the `terraform.tfvars` or `terraform.tfvars.json` in the project root directory. The values placed in these files can be passed through the command line using the following syntax.

`terraform -apply -var-file="terraform.tfvars"`

#### auto.tfvars and auto.tfvars.json

The auto.tfvars is used as a file name extension on varible files that not named exactly terraform.tfvars or terraform.tfvars.json

`terraform -apply -var-file="customvar.auto.tfvars"`

### Order of Terraform Variables

[Terraform Variable - Order of Precedence](https://developer.hashicorp.com/terraform/language/values/variables#variable-definition-precedence)


> If the same variable is assigned multiple values, Terraform uses the last value it finds, overriding any previous values. Note that the same variable cannot be assigned multiple values within a single source.

> Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

- Environment variables

- The terraform.tfvars file, if present.

- The terraform.tfvars.json file, if present.

- Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.

- Any -var and -var-file options on the command line, in the order they are provided. (This includes variables set by a Terraform Cloud workspace.)

## Dealing with Configuration Drift

### What happens is the state file is lost?

Losing your statefile will require tearing down your cloud infrastructure manually.

Terraform import can be used but it may not work for all cloud resources. The terraform providers documenation contains information on what resources can be imported.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)

[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If a resource is deleted or modified manually. Running `terraform plan` will attempt to put the infrastructure back into the expected state.

## Fix using Terraform Refresh

```sh
terraform apply -refresh-only -auto-approve
```

## Terraform Modules

### Terraform Module Structure

The recommendation is to place modules in a `modules` directory when locally developing modules.

## Passing Input Variables 

Input variables can be passed to a module.

```tf
module "terrahouse_aws" {
 source = "./modules/terrahouse_aws"
 user_uuid = var.user_uuid
 bucket_name = var.bucket_name 
}
```

### Module Sources

Modules can be sourced from various locations
- local
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
 source = "./modules/terrahouse_aws" 
}
```

[Module Documenation](https://developer.hashicorp.com/terraform/language/modules/sources)

## Considerations when using ChatGPT to write Terraform

LLMs like ChatGPT may not be trained on the latest documenation about Terraform. It may produce older examples that could be deprecated an example being providers.

## Working with Files in Terraform

### FileExists Function

A built in terraform function to check file existence.

```tf
validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The provided path for index.html does not exist."
  }
```
[FileExists Documentation](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5 Function

The filemd5 function was used in the project to get hash value of file for comparison when file modification took place. This was needed because Terraform doesn't natively track updates to files 

[Filemd5 Documenatation](https://developer.hashicorp.com/terraform/language/functions/filemd5)

### Path Variable

There is a special variable called `path` that allows the ability to reference local paths.

[Special Path Variables](https://developer.hashicorp.com/packer/docs/templates/hcl_templates/path-variables)

```tf
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key    = "index.html"
  source = "${path.root}/public/index.html"
  }

```

## Terraform Locals

A local value assigns a name to an (local variable) expression, so you can use the name multiple times within a module instead of repeating the expression.

```tf
locals {
  s3_origin_id = "myS3Origin"
}
```

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

This allows you to source data from cloud resources
This is useful to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}
output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)

## Working with JSON

This was used to create a json policy inline using HCL.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```

[JSON Encode](https://developer.hashicorp.com/terraform/language/functions/jsonencode)


