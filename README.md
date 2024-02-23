# Phylum CLI

This repository contains **disabled** [Homebrew] formulae for the [Phylum] [CLI].

> **NOTE:** The `phylum` formula in this custom homebrew tap has been disabled
> now that the official Homebrew core tap includes a `phylum-cli` formula that
> does the same thing. The formula was disabled on 22 FEB 2024 to coincide with
> the v6.1.2 release of the Phylum CLI and will no longer install.

[Homebrew]: https://brew.sh/
[Phylum]: https://phylum.io/
[CLI]: https://github.com/phylum-dev/cli

## How do I migrate to the supported formula?

If the Phylum CLI is already installed from this custom `phylum-dev/cli` tap,
follow these steps to migrate to the `phylum-cli` formula found in the core
Homebrew tap:

```sh
# Uninstall the current formula to prevent `phylum` binary conflicts
brew uninstall phylum

# Remove the custom tap to prevent accidentally installing the wrong version
brew untap phylum-dev/cli

# Update and install the new formula from the core tap
brew update
brew install phylum-cli
```

It is even easier if the Phylum CLI was never installed from this custom
`phylum-dev/cli` tap:

```sh
brew install phylum-cli
```

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
