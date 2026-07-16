# maan2003-skills

Public agent skills from `~/.agents/skills`.

## Build

Build the skill directory with:

```sh
nix build .#skills
```

`.#default` and `.#skills` both produce a directory with skills installed under `share/agents/skills`.

## Install / use

Install these skills into the current project with:

```sh
nix run .#install
```

This creates `./.agents/skills/maan2003-skills` as a symlink to the packaged skills and adds `/.agents/skills/maan2003-skills` to the local Git exclude file.

To use these skills from another flake, add this flake as an input and run the installer from your dev shell:

```nix
inputs.maan2003-skills = {
  url = "github:maan2003/public-skills";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

Then include it in `outputs` and call the installer for the current system from your dev shell. For example, with flakebox shells:

```nix
outputs =
  { flake-utils, maan2003-skills, ... }@inputs:
  flake-utils.lib.eachDefaultSystem (
    system:
    let
      # define pkgs and flakeboxLib here
    in
    {
      devShells = flakeboxLib.mkShells {
        shellHook = ''
          ${maan2003-skills.packages.${system}.install}/bin/install-maan2003-skills
        '';
      };
    }
  );
```

The same command can be used from any other dev-shell `shellHook`.
