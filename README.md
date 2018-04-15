# fuchsi overlay

My *private* Gentoo overlay.

## Contents

Libressl patches for
- net-libs/nodejs
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