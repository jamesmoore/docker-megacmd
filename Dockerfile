# syntax=docker/dockerfile:1
FROM ubuntu:26.04

LABEL maintainer="Ruslan Molchanov <ruslanys@gmail.com>"

RUN <<EOF
    set -eux
    MEGACMD_PACKAGE=megacmd_2.7.0-1.1_amd64.deb
    XBUNTU_VERSION=26.04

    # Upgrade
    apt-get update
    apt-get upgrade -y
    apt-get dist-upgrade -y

    # Install dependencies
    apt-get install -y --no-install-recommends ca-certificates wget

    # Download & Install MegaCMD
    wget "https://mega.nz/linux/repo/xUbuntu_${XBUNTU_VERSION}/amd64/${MEGACMD_PACKAGE}"
    apt-get install -y --no-install-recommends "./${MEGACMD_PACKAGE}"

    # Cleanup
    rm "${MEGACMD_PACKAGE}"
    apt-get purge -y --auto-remove wget
    apt-get autoclean -y
    rm -rf /var/lib/apt/lists/*

    mkdir /root/MEGA
EOF

ENTRYPOINT ["mega-cmd-server"]
