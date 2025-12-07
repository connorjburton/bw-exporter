FROM debian:bullseye-slim

RUN apt-get update \
    && apt-get install -y curl unzip jq \
    && curl -sLo /tmp/bw.zip https://vault.bitwarden.com/download/?app=cli&platform=linux \
    && unzip /tmp/bw.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/bw \
    && rm /tmp/bw.zip \
    && apt-get remove -y curl unzip \
    && apt-get autoremove -y \
    && apt-get clean

WORKDIR /app

COPY export.sh /usr/local/bin/export.sh

RUN chmod +x /usr/local/bin/export.sh

ENTRYPOINT ["/usr/local/bin/export.sh"]
