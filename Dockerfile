FROM hashicorp/terraform:1.4.4 AS TF-BUILD

FROM debian:buster-slim
RUN apt-get update; apt-get install unzip curl -y

# Install TF docs
RUN curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-$(uname)-amd64.tar.gz && \
tar -xzf terraform-docs.tar.gz && \
chmod +x terraform-docs && \
mv terraform-docs /usr/local/bin && \
mkdir dev-utils-conf/
COPY tf-doc-conf.yml dev-utils-conf/

# Install TF Lint and Azure plugin - https://github.com/terraform-linters/tflint-ruleset-azurerm
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash
RUN mkdir -p .tflint.d/plugins/ && \
curl -L https://github.com/terraform-linters/tflint-ruleset-azurerm/releases/download/v0.16.0/tflint-ruleset-azurerm_linux_amd64.zip > tflint-ruleset-azurerm.zip && \ 
unzip tflint-ruleset-azurerm.zip -d .tflint.d/plugins/ && \
rm tflint-ruleset-azurerm.zip 
COPY .tflint.hcl dev-utils-conf/

# Install JSON to YML (pipeline variables) converter script
COPY pvar-json2yml.sh /usr/local/bin

# Install Terraform Binary for formatting
COPY --from=TF-BUILD /bin/terraform /usr/local/bin
