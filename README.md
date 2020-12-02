# This repo has been phased out (November 2020)
With the addition of flatpak to the Gentoo main tree the need for this overlay is gone and it will no longer be maintained.

I added a move statement for the alternate libostree naming I used to smoothen the transition.

So long and I hope you enjoyed the journey from a fresh new technology to a stable factor in the ecosystem with me.

---

# flatpak-overlay
A Gentoo ebuild repository (overlay) for the [Flatpak](http://flatpak.org/) application distribution format.

Note that this only installs the Flatpak application, for usage see the main Flatpak website. 

The Flatpak ebuild does not track actual applications installed by Flatpak like Gentoo would. Flatpak uses [OSTree](https://wiki.gnome.org/Projects/OSTree) to install and track applications and runtimes in /var, so the base Gentoo installation will not be touched. It is also possible to install applications and runtimes on a per user basis only.

## How to use this repository?

There are two main methods for making use of this repository, discussed in the sections below.

### Local repositories

For the [local repository](https://wiki.gentoo.org/wiki/Handbook:Parts/Portage/CustomTree#Defining_a_custom_repository) method, create a `/etc/portage/repos.conf/flatpak-overlay.conf` file containing the following bit of text.

```
[flatpak-overlay]
priority = 50
location = <repo-location>/flatpak-overlay
sync-type = git
sync-uri = https://github.com/fosero/flatpak-overlay.git
auto-sync = Yes
```

Change `repo-location` to a path of your choosing and then run `emaint -r flatpak-overlay sync`, Portage should now find and update the repository.

### Layman

You can also use the Layman tool to add and sync the repository, read the instructions on the [Gentoo Wiki](https://wiki.gentoo.org/wiki/Layman#Adding_custom_repositories).

The repositories.xml can be found at `https://raw.githubusercontent.com/fosero/flatpak-overlay/master/repositories.xml`.

### Eselect

You can also use the eselect tool to add and sync the repository, read the instructions on the [Gentoo Wiki](https://wiki.gentoo.org/wiki/Eselect/Repository).

`eselect repository add flatpak-overlay git https://github.com/fosero/flatpak-overlay.git`
