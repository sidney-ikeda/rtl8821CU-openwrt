WIP

# rtl8821CU-openwrt
Port rtl8821CU to openwrt tentative

## Install

Edit your feeds.conf or feed.conf.default and add the following to it:

    #rtl8821CU feed
    src-git rtl8821cu https://github.com/sidney-ikeda/rtl8821CU-openwrt.git

Update your build environment and install the packages:

     $ ./scripts/feeds update rtl8821cu
     $ ./scripts/feeds install -a -p rtl8821cu
     $ make menuconfig

Driver is located in `Kernel modules -> Wireless Drivers -> kmod-rtl8821cu`:

    <*> kmod-rtl8821cu.................................... Driver for Realtek 8821CU

Exit, save and build:

    $ make -j4
