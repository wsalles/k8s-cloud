ARG ALPINE_VERSION=3.18
###################################################################################################
# build the AWS-CLI v2 -------------------------------------------------------------------------
# workaround: https://github.com/aws/aws-cli/blob/2.13.0/proposals/source-install.md#alpine-linux
###################################################################################################
FROM python:3.11-alpine${ALPINE_VERSION} AS builder

ARG AWSCLI_VERSION=2.13.0
ARG AWSCLI_PATH=/opt/aws-cli

WORKDIR /tmp

RUN apk add --no-cache \
    curl \
    make \
    cmake \
    gcc \
    g++ \
    libc-dev \
    libffi-dev \
    openssl-dev
RUN curl https://awscli.amazonaws.com/awscli-${AWSCLI_VERSION}.tar.gz | tar -xz \
    && cd awscli-${AWSCLI_VERSION} \
    && ./configure --prefix=${AWSCLI_PATH} --with-download-deps --with-install-type=portable-exe \
    && make \
    && make install

# reduce image size: remove autocomplete and examples
ARG AWSCLI_LIB_PATH=${AWSCLI_PATH}/lib/aws-cli
RUN rm -rf \
    ${AWSCLI_LIB_PATH}/aws_completer \
    ${AWSCLI_LIB_PATH}/awscli/data/ac.index \
    ${AWSCLI_LIB_PATH}/awscli/examples
RUN find ${AWSCLI_LIB_PATH}/awscli/data -name completions-1*.json -delete
RUN find ${AWSCLI_LIB_PATH}/awscli/botocore/data -name examples-1.json -delete

###################################################################################################
# build the final image ------------------------------------------------------------------------
###################################################################################################
FROM alpine:${ALPINE_VERSION}

COPY --from=builder /opt/aws-cli/ /opt/aws-cli/

WORKDIR /opt
ENV PATH=${PATH}:/opt:/opt/aws-cli/bin

# Tools & Dependencies -------------------------------------------------------------------------------------------------
RUN apk add --no-cache \
    groff \
    curl \
    git \
    jq \
    docker \
    unzip \
RUN rm -rf /var/cache/apk/*

# TERRAFORM ------------------------------------------------------------------------------------------------------------
ENV TERRAFORM_VERSION="1.5.2"
ENV TERRAFORM_FILENAME="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

RUN wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_FILENAME}"
RUN unzip ${TERRAFORM_FILENAME}
RUN chmod 755 terraform
RUN rm -f ${TERRAFORM_FILENAME}

# KUBECTL --------------------------------------------------------------------------------------------------------------
# 1.24 enters maintenance mode on 2023-05-28 and End of Life is on 2023-07-28.
ENV KUBECTL_VERSION="v1.24.15"
RUN wget "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
RUN chmod 755 kubectl

# HELM -----------------------------------------------------------------------------------------------------------------
ENV HELM_VERSION="v3.12.0"
ENV HELM_FILENAME="helm-${HELM_VERSION}-linux-amd64.tar.gz"

RUN wget "https://get.helm.sh/${HELM_FILENAME}"
RUN tar -zxf ${HELM_FILENAME}
RUN mv linux-amd64/helm .
RUN rm -rf linux-amd64 && rm -f ${HELM_FILENAME}

# GITLAB-TERRAFORM -----------------------------------------------------------------------------------------------------
ENV GITLAB_TERRAFORM_VERSION="v1.4.0"
RUN wget "https://gitlab.com/gitlab-org/terraform-images/-/raw/${GITLAB_TERRAFORM_VERSION}/src/bin/gitlab-terraform.sh" -O gitlab-terraform
RUN chmod +x gitlab-terraform

# ----------------------------------------------------------------------------------------------------------------------