# Terraform Beginner Bootcamp 2023  

## Semantic Versioning :mage:

This project will utilize semantic version for its tagging
[semver.org](https://semver.org)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes

The Terraform CLI instructions have changed due to GPG keyring changes. Had to edit the gitpod.yml file to install the CLI. In order to fix I referred to the Terraform Install instructions via Terraform Docs.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform)

### Consideration for Linux Distribution

This project i built against Ubuntu. Please consider checking your Linux Distribution and change accordinlgy to your distribution needs.

[How to check OS Vesion on Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
$ cat /etc/*release*
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.3 LTS"
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg decprecation issues, we noticed the bash commands were very lengthy so I created a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This will allow us to debug and execute manually Terraform CLI install.
- This will allow better portability for other projects that need Terraform CLI.

#### Shebang Considerations

A Shebang (pronounced Sha-bang) tells the bash script what program that will interpet the script. eg. `#!/bin/bash`

ChatGPT recommended this format for bash for portablility. `#!/bin/env bash`

- for portability for different OS distributions
- will searh the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script we use the `./` shorthand notication ot execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml we ned to point the scrip to a program to interpert it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our scripts executable we need to change linux permissions for the fix to be executable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively

```sh
chmod 744 ./bin/install_terraform_cli
```
https://en.wikipedia.org/wiki/Chmod

### GitHub Lifecycle (Befor, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks#prebuild-and-new-workspaces

### Working with Env Vars

We can list outall Environment Variables (Env Vars) using the `env` command
We can filter specific env vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting Env Vars

In the terminal, using `export HELLO='world`
In the terminal, we can unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO=`world` ./bin/print_message
```
Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO=`world`

echo $HELLO
```

## Printing Env Vars

We can pring an env var using echo eg. `echo $HELLO`

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

if you want Env Vars to persistent across bash terminals, you need to set env vars in your bash profle. 
eg `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```
All future workspaces launched will set the env vars for all bash terminals opened in those workspaces.

You can also set env vars in the `.gitpod.yml` but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for this project via a BASH script.

[/bin/install_aws_cli](/bin/install_aws_cli)

[Getting Started - Installing the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html)

[AWS Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that lookslike this:

```json
{
    "UserId": "AJBANQA1EPERKABFPROAZ",
    "Account": "123456789652",
    "Arn": "arn:aws:iam::123456789652:user/tf-userA"
}
```

We'll need to generate AWS CLI creds in IAM User to have access to use the AWS CLI.