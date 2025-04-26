[private]
default:
    @just --choose

build:
  flatpak run org.flatpak.Builder \
    --install \
    --keep-build-dirs \
    --install-deps-from=flathub \
    --force-clean \
    build --user com.nexusmods.app.yaml

lint:
  flatpak run --command=flatpak-builder-lint org.flatpak.Builder manifest com.nexusmods.app.yaml
  flatpak run --command=flatpak-builder-lint org.flatpak.Builder appstream NexusMods.App/src/NexusMods.App/com.nexusmods.app.metainfo.xml


update-deps:
  #!/bin/sh
  RUNTIME="24.08"
  DOTNET_VERS="9"
  DOTNET_GENERATOR=""

  # Download upstream repo and flatpak-builder-tools
  git submodule update --init --recursive

  # set this commit hash to latest upstream release
  git --git-dir=NexusMods.App/.git/ checkout ecff6c508df2d47c3470bc67aa91b160dc8c203b

  flatpak-builder-tools/dotnet/flatpak-dotnet-generator.py nuget-sources.aarch64.json \
    --destdir nuget-sources \
    --dotnet $DOTNET_VERS \
    --runtime linux-arm64 \
    --freedesktop $RUNTIME \
    NexusMods.App/NexusMods.App.sln

  flatpak-builder-tools/dotnet/flatpak-dotnet-generator.py nuget-sources.x86_64.json \
    --destdir nuget-sources \
    --dotnet $DOTNET_VERS \
    --runtime linux-x64 \
    --freedesktop $RUNTIME \
    NexusMods.App/NexusMods.App.sln

  # should be march agnostic
  flatpak-builder-tools/dotnet/flatpak-dotnet-generator.py  nuget-sources.json \
    --destdir nuget-sources \
    --dotnet $DOTNET_VERS \
    --freedesktop $RUNTIME \
    NexusMods.App/src/NexusMods.App/NexusMods.App.csproj

flathub: update-deps lint build
