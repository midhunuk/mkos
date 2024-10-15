sudo modinfo -n evdi /lib/modules/$(uname -r)/extra/evdi.ko.xz

sudo unxz $(modinfo -n evdi)

sudo /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 ./MOK.priv \
  ./MOK.der /lib/modules/$(uname -r)/extra/evdi.ko

sudo xz -f /lib/modules/$(uname -r)/extra/evdi.ko
