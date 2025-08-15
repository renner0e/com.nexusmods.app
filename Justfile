[private]
default:
    @just --choose


build:
  flatpak run org.flatpak.Builder --force-clean --install build --verbose --user org.x.webapp-manager.yaml


deps:
  python ~/.local/bin/flatpak-pip-generator.py --runtime=org.gnome.Sdk//master beautifulsoup4 configobj pillow setproctitle tldextract --yaml --checker-data --output python-deps


run-debug:
  flatpak run --command=bash org.x.webapp-manager

run:
  flatpak run org.x.webapp-manager


data-checker:
  flatpak run org.flathub.flatpak-external-data-checker ./org.x.webapp-manager.yaml


lint:
  flatpak run --command=flatpak-builder-lint org.flatpak.Builder manifest ./org.x.webapp-manager.yaml

