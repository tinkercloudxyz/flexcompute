# FlexCompute by Datacom Cloud - Code Samples

![Last Commit](https://img.shields.io/github/last-commit/tinkercloudxyz/flexcompute?logo=github)
[![Changelog](https://img.shields.io/badge/changelog-read-blue?logo=github)](CHANGELOG.md)

[![Terraform][terraform-shield]][terraform-url]
[![PowerShell][powershell-shield]][powershell-url]

## Table of Contents

1. [Introduction](#Introduction)
1. [Requirements](#Requirements)
1. [Configuration](#Configuration)
1. [Build](#Build)
1. [Credits](#Credits)

## Introduction

This repository provides infrastructure-as-code examples for automating the provisioning and configuration of resources on FlexCompute by Datacom Cloud using configuration tools ([HashiCorp Terraform][terraform-url], [VMware PowerCLI][powershell-url]) interacting with the [VMware Cloud Director API][vcd-api-url].

The following code samples are available:

### HashiCorp Terraform

* **Building Blocks** *(Level 100)*
  * VM - Basic
* **Simple Stack** *(Level 200)*
* **Advanced Stack** *(Level 300)*

### VMware PowerCLI

* **Building Blocks** *(Level 100)*
* **Stack** *(Level 200)*
* **Advanced Stack** *(Level 300)*

> **Note**
>
> * **Building blocks** focus on the provisioning and configuration of a single resource
>
> * **Simple Stack** combines builing blocks e.g. VM + network + firewall rule
>
> * **Advanced Stack** combines simple stacks to provide a whole solution e.g. 3 tier application

## Requirements

**HashiCorp Terraform**:

* Terraform 1.2.1+

    > **Note**
    >
    > Available as a [local installation][terraform-download] or in [Terraform Cloud][terraform-cloud]

**VMware PowerCLI**:

* PowerShell 5.1+

  > **Note**
  >
  > Follow the [installation guide][powercli-guide] to configure PowerCLI

**Platform**:

* VMware Cloud Director 10.2+

## Configuration

### Step 1 - Download the Release

Download the [**latest**](https://github.com/tinkercloudxyz/flexcompute/releases) release.

You may also clone `main` for the latest prerelease updates.

**Example**:

```console
git clone https://github.com/tinkercloudxyz/flexcompute.git
```

The directory structure of the repository.

```console
├── LICENSE
├── NOTICE
├── README.md
├── terraform
│   ├── 100-<buidling block>
│   │   ├──main.tf
│   │   ├──variable.tf
│   │   ├──version.tf
│   │   └──terraform.tfvars.example
│   ├── 200-<simple stack>
│   │   ├──main.tf
│   │   ├──variable.tf
│   │   ├──version.tf
│   │   └──terraform.tfvars.example
│   └── 300-<advanced stack>
│       ├──main.tf
│       ├──variable.tf
│       ├──version.tf
│       └──terraform.tfvars.example
└── powercli
    ├── 100-<buidling block>
    │   ├──main.tf
    │   ├──variable.tf
    │   ├──version.tf
    │   └──terraform.tfvars.example
    ├── 200-<simple stack>
    │   ├──main.tf
    │   ├──variable.tf
    │   ├──version.tf
    │   └──terraform.tfvars.example
    └── 300-<advanced stack>
        ├──main.tf
        ├──variable.tf
        ├──version.tf
        └──terraform.tfvars.example

```

> **Warning**
>
> When forking the project for upstream contribution, please be mindful not to make changes that may expose your sensitive information, such as passwords, keys, certificates, etc.

### Step 2 - Configure Account Privileges in VMware Cloud Director on FlexCompute

Create a user account or service token with required level of priviledges for provisioning and configuring resources on VMware Cloud Director.

### Step 3 - Configure the Variables

#### Copy the Example Variables

Copy the example variable file provided for each code sample and populate with relevant updated values for the variables

## Build

### Build with Variables Files

Using the variable file created by cloning the example, execute the code sample using the appropriate intepreter e.g. Terraform, PowerCLI

## Credits

[//]: Links

[terraform-shield]: https://img.shields.io/badge/code-Terraform-orange?logo=terraform
[terraform-url]: https://registry.terraform.io/providers/vmware/vcd/latest/docs
[terraform]: https://www.terraform.io/
[terraform-download]: https://www.terraform.io/downloads
[terraform-cloud]: https://cloud.hashicorp.com/products/terraform
[powershell-shield]: https://img.shields.io/badge/code-Powershell-blue?logo=powershell
[powershell-url]: https://developer.vmware.com/docs/powercli/latest/products/vmwareclouddirector/
[powercli-guide]: https://developer.vmware.com/powercli/installation-guide
[vcd-api-url]: https://developer.vmware.com/apis/vmware-cloud-director/latest/