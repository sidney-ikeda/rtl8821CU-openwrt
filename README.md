WIP:

2022-06-20
Can be compiled in openwrt v22.03.0-rc1 but at device cause freeze when try to search wifi AP.

# rtl8821CU-openwrt
Attempt to port rtl8821CU driver to openwrt

## Install

git clone https://github.com/sidney-ikeda/rtl8821CU-openwrt.git to folder: openwrt/package/kernel/

Update your build environment and install the packages:

     $ ./scripts/feeds update -a
     $ ./scripts/feeds install -a
     $ make menuconfig

Driver is located in `Kernel modules -> Wireless Drivers -> kmod-rtl8821cu`:

    <*> kmod-rtl8821cu.................................... Driver for Realtek 8821CU

Exit, save and build:

    $ make -j4
