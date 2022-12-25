FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH = "v5.10.41/rcar-5.1.4-xt0.1"
SRCREV = "${AUTOREV}"
LINUX_VERSION = "5.10.41"

SRC_URI = " \
    git://github.com/xen-troops/linux.git;branch=${BRANCH};protocol=https \
    file://defconfig \
  "
