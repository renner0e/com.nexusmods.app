WIP

upstream https://github.com/Nexus-Mods/NexusMods.App/

https://nexus-mods.github.io/NexusMods.App/developers/Contributing/#for-package-maintainers

https://github.com/flathub/org.freedesktop.Sdk.Extension.dotnet9

https://github.com/flatpak/flatpak-builder-tools/tree/master/dotnet

https://docs.flatpak.org/en/latest/dotnet.html



#Required Dependencies:

[`flatpak-builder`](https://flathub.org/apps/org.flatpak.Builder) installed from flatpak

`git` on host

`python` for [`flatpak-dotnet-generator.py`](https://github.com/flatpak/flatpak-builder-tools/tree/master/dotnet)

[`just`](https://github.com/casey/just)


# How to make a new release

`just flathub`


# How to use just recipes

`just` see all recipes

`just pull` to refresh the upstream repo so that we can generate sources with:

`just data-checker` invokes [this](https://github.com/flathub-infra/flatpak-external-data-checker)

`just update-deps`, refresh `nuget-sources*.json` with `flatpak-dotnet-generator.py`

`just lint` invokes `flatpak-builder` provided linters for the flatpak manifest and appstream stuff

`just build` builds the flatpak and installs it
