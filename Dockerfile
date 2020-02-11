FROM gcr.io/cloud-builders/gcloud

RUN apt-get update && \
    apt-get -y install wget ca-certificates && \
    wget -O /usr/local/bin/cloud_sql_proxy https://storage.googleapis.com/cloudsql-proxy/v1.16/cloud_sql_proxy.linux.386 && \
    chmod +x /usr/local/bin/cloud_sql_proxy && \
    wget -O /usr/local/bin/dbmate https://github.com/amacneil/dbmate/releases/download/v1.7.0/dbmate-linux-amd64 && \
    chmod +x /usr/local/bin/dbmate && \
    apt-get remove --purge -y curl unzip && \
    apt-get --purge -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Needed to access gcloud beta secrets
RUN gcloud components update

ENV PATH=/usr/local/bin/:$PATH
COPY wrapper.bash /builder/wrapper.bash
ENTRYPOINT ["/builder/wrapper.bash"]
