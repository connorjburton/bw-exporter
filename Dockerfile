FROM debian:bullseye-slim

# Define the version and checksum for 2026.4.1
ENV BW_VERSION="2026.4.1"
ENV BW_SHA256="2172dc63f821fcbd4b4ce65e7106f1ebab26b6cb16c9c8a5b28230dcc6f8a774"

RUN apt-get update \
    && apt-get install -y curl zip jq \
    && curl -sLo /tmp/bw.zip "https://github.com/bitwarden/clients/releases/download/cli-v${BW_VERSION}/bw-linux-${BW_VERSION}.zip" \
    # VERIFICATION STEP
    && echo "${BW_SHA256} /tmp/bw.zip" | sha256sum -c - \
    && unzip /tmp/bw.zip -d /usr/local/bin/ \
    && chmod +x /usr/local/bin/bw \
    && rm /tmp/bw.zip \
    && apt-get purge -y curl zip \
    && apt-get autoremove -y \
    && apt-get clean

# Create a non-root user for execution
RUN useradd -m bwuser
WORKDIR /home/bwuser

COPY --chown=bwuser:bwuser export.sh /usr/local/bin/export.sh
RUN chmod +x /usr/local/bin/export.sh

USER bwuser

ENTRYPOINT ["/usr/local/bin/export.sh"]
