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