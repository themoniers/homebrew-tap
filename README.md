# AppLinkly Homebrew tap

Installs the **AppLinkly Agent CLI** (`applinkly`), which puts the apps running on this machine on
their public AppLinkly addresses.

```sh
brew install themoniers/applinkly/applinkly

applinkly start                 # run it in this terminal (Ctrl-C stops it)
# or in the background:
applinkly service install       # same as: brew services start applinkly
applinkly service login
```

This repository holds only the Homebrew formula. The program is closed source; the formula
downloads its prebuilt binaries, verified by SHA-256, from the AppLinkly release routes.

Other ways to install, and the desktop app: https://applinkly.com/download
