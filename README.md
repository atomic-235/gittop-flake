# gittop-flake

[gittop](https://github.com/hjr265/gittop), an interactive Git repository
browser, packaged from the upstream release tarballs.

Upstream publishes static Go binaries, so nothing needs patching or bundling:
the flake fetches the official asset and pins its hash in `version.json`.

## Packages

| Attribute | Contents |
|---|---|
| `packages.<system>.default` | `gittop` |
| `packages.<system>.gittop` | alias of `default` |

`overlays.default` provides `pkgs.gittop`.

## Usage

```nix
{
  inputs.gittop-flake.url = "github:atomic-235/gittop-flake";
  inputs.gittop-flake.inputs.nixpkgs.follows = "nixpkgs";
}
```

```nix
nixpkgs.overlays = [ inputs.gittop-flake.overlays.default ];
# pkgs.gittop
```

## Updates

CI runs weekly (Monday 06:00 UTC): resolve the latest GitHub release, hash the
`gittop_<version>_linux_{amd64,arm64}.tar.gz` assets, write `version.json`,
build, commit and tag `v<version>`. No asset of its own is published — the
package *is* the upstream artifact.

Supported: `x86_64-linux`, `aarch64-linux`.
