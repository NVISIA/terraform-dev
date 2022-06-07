# Introduction
This repo containers utilities used to support Terraform module development and documentation. The tools are packaged in a Docker image/container for easy use be developer. You just need docker to run them.

The following tools are included in the container:

* [Terraform documentation tool - `terraform-docs`](https://github.com/terraform-docs/terraform-docs) 
* [Terraform linting tool - `TFLint`](https://github.com/terraform-linters/tflint)
---

## Using the Containerized Utilities for Terraform development
From the root module of any Terraform project, you can run the commands below.

### Running Terraform Docs
```bash
docker run -v ${PWD}:/source nvisia/terraform-dev:1.0 terraform-docs -c /dev-utils-conf/tf-doc-conf.yml markdown /source > README.md
```

### Running Terraform Format
```bash
docker run -v ${PWD}:/source nvisia/terraform-dev:1.0 terraform fmt /source
```
### Running Terraform Linter
```bash
docker run -v ${PWD}:/source nvisia/terraform-dev:1.0 tflint -c /dev-utils-conf/.tflint.hcl /source
```

---

## Build the Container

1. Review Dockerfile (versions of included utilities)
2. Build the container image with the proper name and tag (increment the version tag, i.e., v0.6 >> v0.7)
_don't forget to include the "." at the end of the command_

```bash
docker build -t nvisia/terraform-dev:1.0 .
```

3. Push the container to Artifactory

```bash
# You need to login to Artifactory first...
docker login nvisia

# Then push the image
docker image push nvisia/terraform-dev:1.0
```

