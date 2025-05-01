WIP

Currently fails with:
```
❯ flatpak run --command=bash com.nexusmods.app
[📦 com.nexusmods.app ~]$ /app/bin/NexusMods.App
Unhandled exception. System.AggregateException: One or more errors occurred. (Failed to acquire the lock for the single process.)
---> NexusMods.SingleProcess.Exceptions.SingleProcessLockException: Failed to acquire the lock for the single process.
at NexusMods.SingleProcess.CliServer.StartTcpListenerAsync() in /run/build/app/src/NexusMods.SingleProcess/CliServer.cs:line 72
at NexusMods.SingleProcess.CliServer.StartCliServerAsync() in /run/build/app/src/NexusMods.SingleProcess/CliServer.cs:line 58
--- End of inner exception stack trace ---
at System.Threading.Tasks.Task.ThrowIfExceptional(Boolean includeTaskCanceledExceptions)
at System.Threading.Tasks.Task.Wait(Int32 millisecondsTimeout, CancellationToken cancellationToken)
at System.Threading.Tasks.Task.Wait(TimeSpan timeout, CancellationToken cancellationToken)
at System.Threading.Tasks.Task.Wait(TimeSpan timeout)
at NexusMods.App.Program.Main(String[] args) in /run/build/app/src/NexusMods.App/Program.cs:line 94
Aborted (core dumped)
```


[Upstream](https://github.com/Nexus-Mods/NexusMods.App)

[Upstream Contrib Docs](https://nexus-mods.github.io/NexusMods.App/developers/Contributing/#for-package-maintainers)

Flatpak Docs:
https://github.com/flathub/org.freedesktop.Sdk.Extension.dotnet9

https://github.com/flatpak/flatpak-builder-tools/tree/master/dotnet

https://docs.flatpak.org/en/latest/dotnet.html



# Required Dependencies:

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
