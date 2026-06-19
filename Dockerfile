# syntax=docker/dockerfile:1
FROM ubuntu:24.04

LABEL maintainer="Ruslan Molchanov <ruslanys@gmail.com>"

RUN <<EOF
    set -e

    # Upgrade
    apt-get update
    apt-get upgrade -y
    apt-get dist-upgrade -y

    # Install dependencies
    apt-get install -y --no-install-recommends ca-certificates wget

    # Download & Install MegaCMD
    wget https://mega.nz/linux/repo/xUbuntu_25.04/amd64/megacmd_2.5.1-1.1_amd64.deb
    dpkg -i megacmd_2.4.0-1.1_amd64.deb || true
    apt-get install -f -y

    # Cleanup
    rm megacmd_2.4.0-1.1_amd64.deb
    apt-get purge -y --auto-remove wget
    apt-get autoclean -y
    rm -rf /var/lib/apt/lists/*

    mkdir /root/MEGA
EOF

ENTRYPOINT ["mega-cmd-server"]
