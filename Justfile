[private]
default:
    @just --choose


build:
  flatpak run org.flatpak.Builder --force-clean --install --install-deps-from=flathub build --verbose --user io.github.kavishdevar.Librepods.yaml

run-debug:
  flatpak run --command=bash io.github.kavishdevar.Librepods

run:
  flatpak run io.github.kavishdevar.Librepods

lint:
  flatpak run --command=flatpak-builder-lint org.flatpak.Builder manifest ./io.github.kavishdevar.Librepods.yaml


