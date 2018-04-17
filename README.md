# fuchsi overlay

My *private* Gentoo overlay.

## Contents

Libressl patches for
- net-libs/nodejs
- net-wireless/aircrack-ng
- net-wireless/hostapd
- net-wireless/wpa_supplicant

Up to date rust stable ebuilds
- dev-lang/rust-1.25.0
- dev-util/cargo-0.26.0
- virtual/rust-1.25.0

Up to date wine ebuilds
- app-emulation/wine-vanilla-3.5
- app-emulation/wine-vanilla-3.6

A working [dxvk](https://github.com/doitsujin/dxvk) ebuild *WIP*
- app-emulation/dxvk-0.42


**Note**  
The dxvk has some quirks. It depends on `cross-x86_64-w64-mingw32/mingw64-runtime`, which does not exist in the normal portage tree.  
You need to install it via crossdev. See the [Gentoo Wiki](https://wiki.gentoo.org/wiki/Mingw) for instructions.  

Also you have to pass `EXTRA_ECONF="--enable-threads=posix"` when emerging `cross-x86_64-w64-mingw32/gcc` to get pthreads in mingw.  

As an extra, you have to emerge app-emulation/dxvk with `FEATURES="-usersandbox"` if it's enabled, or wine shits the bed.

The [libsodium](https://pecl.php.net/libsodium) extension for PHP < 7.2
- dev-php/pecl-libsodium-1.0.7 for PHP 5.6, 7.0 and 7.1
- dev-php/pecl-libsodium-2.0.9 for PHP 7.0 and 7.1

Hashcat utilites with tools like the new cap2hccapx
- app-crypt/hashcat-utils

[Endless Sky](https://endless-sky.github.io)
- games-strategy/endless-sky

## Installation

Add `https://github.com/fuchsi/overlay/raw/master/repo.xml` to your overlays list.  

/etc/layman/layman.cfg
```
overlays  :
    https://api.gentoo.org/overlays/repositories.xml
    https://github.com//fuchsi/overlay/raw/master/repo.xml
```

Add the overlay via layman
```bash
layman --list
layman --add fuchsi
```