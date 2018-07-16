FROM debian:stretch-slim@sha256:aa33563fd6dc2b14e8cae20cc74f4581d4cb89a3952d87b4cab323707040f035

RUN set -ex; \
  export DEBIAN_FRONTEND=noninteractive; \
  runDeps='python'; \
  buildDeps='curl ca-certificates'; \
  apt-get update && apt-get install -y $runDeps $buildDeps --no-install-recommends; \
  \
  mkdir /opt/gsutil; \
  curl -SLs "https://storage.googleapis.com/pub/gsutil.tar.gz" | tar -xvzf - --strip-components=2 -C /opt/gsutil; \
  ln -s /opt/gsutil/gsutil /usr/local/bin/gsutil; \
  \
  apt-get purge -y --auto-remove $buildDeps; \
  rm -rf /var/lib/apt/lists/*; \
  rm -rf /var/log/dpkg.log /var/log/alternatives.log /var/log/apt
