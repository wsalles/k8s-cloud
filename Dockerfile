FROM alpine:3.18.0

WORKDIR /opt
ENV PATH=${PATH}:/opt

# Tools & Dependencies -------------------------------------------------------------------------------------------------
RUN apk add --no-cache \
    curl \
    python3 \
    py3-pip \
    gcompat \
    idn2-utils \
    git \
    jq \
    openssh \
    docker \
    unzip \
    make
RUN rm -rf /var/cache/apk/*

# TERRAFORM ------------------------------------------------------------------------------------------------------------
ENV TERRAFORM_VERSION="1.4.6"
ENV TERRAFORM_FILENAME="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

RUN wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_FILENAME}"
RUN unzip ${TERRAFORM_FILENAME}
RUN chmod 755 terraform
RUN rm -f ${TERRAFORM_FILENAME}

# AWS CLI --------------------------------------------------------------------------------------------------------------
ENV AWS_CLI_VERSION="2.13.0"
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-${AWS_CLI_VERSION}.zip" \
         -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm -rf ./aws

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