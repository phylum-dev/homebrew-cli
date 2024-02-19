# Phylum CLI

This repository contains **deprecated** [Homebrew] formulae for the [Phylum] [CLI].

> **NOTE:** The `phylum` formula in this custom homebrew tap has been deprecated
> now that the official Homebrew core tap includes a `phylum-cli` formula that
> does the same thing. A future release of the Phylum CLI will result in the
> formula from this custom tap being **disabled** and not possible to install.

[Homebrew]: https://brew.sh/
[Phylum]: https://phylum.io/
[CLI]: https://github.com/phylum-dev/cli

## How do I migrate to the supported formula?

It is strongly recommended to migrate to the `phylum-cli` formula found in the
core Homebrew tap ASAP. If the Phylum CLI is already installed from this custom
`phylum-dev/cli` tap, follow these steps to migrate:

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

## How do I install these formulae?

> **NOTE:** These instructions are only included for historical purposes.
> It is recommended to install the CLI from the core Homebrew tap instead.

`brew install phylum-dev/cli/<formula>`

Or `brew tap phylum-dev/cli` and then `brew install <formula>`.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
