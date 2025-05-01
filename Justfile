[private]
default:
    @just --choose

build:
  flatpak run org.flatpak.Builder \
    --install \
    --keep-build-dirs \
    --install-deps-from=flathub \
    --force-clean \
    --verbose \
    build --user com.nexusmods.app.yaml

lint:
  flatpak run --command=flatpak-builder-lint org.flatpak.Builder manifest com.nexusmods.app.yaml
  flatpak run --command=flatpak-builder-lint org.flatpak.Builder appstream NexusMods.App/src/NexusMods.App/com.nexusmods.app.metainfo.xml

data-checker:
  flatpak run org.flathub.flatpak-external-data-checker com.nexusmods.app.yaml

pull:
  #!/bin/bash
  if [ -d "NexusMods.App/.git" ]; then
    echo "Directory NexusMods upstream repo folder exists. Pulling latest changes..."
    git --git-dir=NexusMods.App/.git pull
  else
  # Download upstream repo
    echo " upstream repo does not exist. Cloning latest release..."
    LATEST_TAG=$(curl -s https://api.github.com/repos/Nexus-Mods/NexusMods.App/releases/latest | grep tag_name | cut -d '"' -f 4)
    git clone --depth 1 --branch "$LATEST_TAG" "https://github.com/Nexus-Mods/NexusMods.App.git"
  fi


  if [ -d "flatpak-builder-tools/.git" ]; then
      echo "flatpak builder tools folder exists. Pulling latest changes..."
      git --git-dir=flatpak-builder-tools/.git pull
    else
    # flatpak-builder-tools
      echo "flatpak builder tools folder does not exist. Cloning latest release..."
      git clone --depth 1 https://github.com/flatpak/flatpak-builder-tools
    fi

update-deps:
  #!/bin/sh
  RUNTIME="24.08"
  DOTNET_VERS="9"

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
  flatpak-builder-tools/dotnet/flatpak-dotnet-generator.py nuget-sources.json \
    --destdir nuget-sources \
    --dotnet $DOTNET_VERS \
    --freedesktop $RUNTIME \
    NexusMods.App/src/NexusMods.App/NexusMods.App.csproj

flathub: pull data-checker update-deps build
