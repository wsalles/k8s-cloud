FROM alpine:3.13.5

WORKDIR opt/
ENV PATH=${PATH}:/opt

# TERRAFORM ------------------------------------------------------------------------------------------------------------
ENV TERRAFORM_VERSION="0.15.3"
ENV TERRAFORM_FILENAME="terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

RUN wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/${TERRAFORM_FILENAME}"
RUN unzip ${TERRAFORM_FILENAME}
RUN chmod 755 terraform
RUN rm -f ${TERRAFORM_FILENAME}

# AWS-CLI --------------------------------------------------------------------------------------------------------------
RUN apk add --no-cache \
        python3 \
        py3-pip \
        make
RUN pip3 install --upgrade pip
RUN pip3 install awscli \
    && rm -rf /var/cache/apk/*

# KUBECTL --------------------------------------------------------------------------------------------------------------
ENV KUBECTL_VERSION="v1.19.7"
RUN wget "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
RUN chmod 755 kubectl

# HELM -----------------------------------------------------------------------------------------------------------------
ENV HELM_VERSION="v3.5.4"
ENV HELM_FILENAME="helm-${HELM_VERSION}-linux-amd64.tar.gz"

RUN wget "https://get.helm.sh/${HELM_FILENAME}"
RUN tar -zxf ${HELM_FILENAME}
RUN mv linux-amd64/helm .
RUN rm -rf linux-amd64 && rm -f ${HELM_FILENAME}

# ----------------------------------------------------------------------------------------------------------------------