# K8S Cloud

[![ci](https://github.com/wsalles/k8s-cloud/actions/workflows/ci.yml/badge.svg)](https://github.com/wsalles/k8s-cloud/actions/workflows/ci.yml)
![terraform](https://img.shields.io/badge/terraform-v1.5.2-%237B42BC?style=flat-square&logo=terraform&logoColor=%237B42BC)
![wsalles/iac:tagversion](https://img.shields.io/docker/v/wsalles/iac-cli?logo=docker&label=wsalles%2Fiac-cli&link=https%3A%2F%2Fhub.docker.com%2Frepository%2Fdocker%2Fwsalles%2Fiac-cli%2Fgeneral)

![](cover.png)

---

### Getting Started

This is a simple project using **EKS** on **AWS**.

I'm not using the modules in this project because I wanted to build an EKS Cluster with as few resources as possible.

But for sure, the best practice is to use [**Terraform EKS module by AWS**](https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest) (official)

or [**Amazon EKS Blueprints for Terraform**](https://github.com/aws-ia/terraform-aws-eks-blueprints), which I recommend as well.

---

## Summary

- [Requirements](#requirements)
- [Steps in the AWS folder](#steps-in-the-aws-folder)
- [Steps in the Kubernetes folder](#steps-in-the-kubernetes-folder)
- [Remember to destroy everything if you don't need it anymore](#x-remember-to-destroy-everything-if-you-dont-need-it-anymore)
- [Tips Session](#tips-session)
  - [How to use **asdf**](#how-to-use-asdf)
- [Credits](#credits)

---

## Requirements

Follow the necessary tools that you will need:

- [terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [helm](https://helm.sh/docs/intro/install/)

> Tip: see [here]() how to use [**asdf**](https://asdf-vm.com/guide/getting-started.html#getting-started).

---

## Steps in the AWS folder

First of all, let's prepare our infrastructure.

1. First, we need access the folder `aws` and then, do:
   ```sh
   make dev create-workspace
   ```

1. Show all the changes that will be made:
   ```sh
   make plan
   ```

1. If you're right, do:
   ```sh
   make apply
   ```

> Ps: the **make plan** target is doing: **init**, **validate** and **fmt** as well.

[⇪ back to top](#summary)

---

## Steps in the Kubernetes folder

If everything goes well, we can move on:

1. Adding Kubernetes Cluster context:

   Now, you need to go back one level in your directory and access the kubernetes folder:

   ```shell
   make context-config
   ```

1. In this step, you need to install EBS CSI Driver and then, you can deploy it:

   ```shell
   make ebs-install
   
   make ebs-config
   ```

1. Now, we let's deploy the `metric-server` and `traefik`:

   ```shell
   make setup
   ```

1. Ok, finally you need to deploy a app, for this, do:

   ```shell
   make deploy
   ```

If you need to delete, just do: `make delete`

[⇪ back to top](#summary)

---

## :x: Remember to destroy everything if you don't need it anymore.

To do this, go back to the AWS folder and do:

```bash
make destroy
```

[⇪ back to top](#summary)

---

## Tips Session

### How to use ASDF

You can use [**asdf**](https://asdf-vm.com/guide/getting-started.html#getting-started) to make your life easier.

- **Examples:**
  - asdf plugin-add terraform
  - asdf install terraform latest
  - asdf global terraform latest

- **Useful information:**
  - [Using Existing Tool Version Files](https://asdf-vm.com/guide/getting-started.html#using-existing-tool-version-files)
  - [Other ways to work with versions](https://asdf-vm.com/manage/versions.html)

[⇪ back to top](#summary)

---
## Credits

- [Terraform Docs for AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Traefik: User Guide](https://doc.traefik.io/traefik/v1.7/user-guide/kubernetes/)
- [Metrics Server](https://github.com/kubernetes-sigs/metrics-server)
- [NanoShots *by Matheus Fidelis*](https://www.nanoshots.com.br/)
- [IaC: Add New EBS Volume To AWS EKS Cluster *by Tony*](https://tonylixu.medium.com/infra-as-code-terraform-4-add-new-ebs-volume-to-aws-eks-cluster-857818523d73)

[⇪ back to top](#summary)
