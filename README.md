# fuchsi overlay

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