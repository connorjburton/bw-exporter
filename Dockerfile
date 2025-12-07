FROM debian:bullseye-slim

RUN apt-get update \
    && apt-get install -y curl jq \
    && curl -sLo /usr/bin/bw https://vault.bitwarden.com/download/?app=cli&platform=linux \
    && chmod +x /usr/bin/bw \
    && apt-get remove -y curl \
    && apt-get autoremove -y \
    && apt-get clean

WORKDIR /app

COPY export.sh /usr/local/bin/export.sh

RUN chmod +x /usr/local/bin/export.sh

ENTRYPOINT ["/usr/local/bin/export.sh"]
