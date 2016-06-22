# flatpak-overlay
A Gentoo ebuild overlay for the [Flatpak](http://flatpak.org/) application distribution format.

Note that this only installs the Flatpak application, for usage see the main Flatpak website. 

The Flatpak ebuild does not track actual applications installed by Flatpak like Gentoo would. Flatpak uses [OSTree](https://wiki.gnome.org/Projects/OSTree) to install and track applications and runtimes in /var, so the base Gentoo installation will not be touched. It is also possible to install applications and runtimes on a per user basis only.

## How to use this overlay?

The OSTree ebuild used in the tree is a *live ebuild* for now, requiring it to be unmasked by adding `=sys-fs/ostree-9999 **` to `/etc/portage/package.keywords`. See the [Gentoo wiki](https://wiki.gentoo.org/wiki//etc/portage/package.accept_keywords) for more info.

There are two main methods for making use of this overlay, discussed in the sections below.

### Local overlays

For the [local overlay](https://wiki.gentoo.org/wiki/Overlay/Local_overlay) method, create a `/etc/portage/repos.conf/flatpak-overlay.conf` file containing the following bit of text.

```
[flatpak-overlay]
priority = 50
location = <repo-location>/flatpak-overlay
sync-type = git
sync-uri = git://github.com/fosero/flatpak-overlay.git
auto-sync = Yes
```

Adapt <repo-location> to a path of your choosing and then run `emerge --sync`, Portage should now find and update the repository.

### Layman

You can also use the Layman tool to add and sync the overlay, read the instructions on the [Gentoo Wiki](http://wiki.gentoo.org/wiki/Layman#Adding_custom_overlays).

The repositories.xml can be found at `https://github.com/fosero/flatpak-overlay/repositories.xml`.
