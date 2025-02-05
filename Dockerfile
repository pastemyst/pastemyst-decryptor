FROM dlang2/dmd-ubuntu:2.096.1

RUN apt-get update && \
    apt-get install -y libscrypt-dev

WORKDIR /app

COPY . .

RUN apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

RUN git config --global --add safe.directory /app

ENV DC=dmd

ENTRYPOINT dub run
