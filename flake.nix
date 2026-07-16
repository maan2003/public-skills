{
  description = "maan2003's public agent skills";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      packages = forAllSystems (
        system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        rec {
          skills = pkgs.runCommand "maan2003-skills" { } ''
            mkdir -p "$out/share/agents/skills"
            cp -R ${./skills}/. "$out/share/agents/skills/"
          '';

          install = pkgs.writeShellApplication {
            name = "install-maan2003-skills";
            runtimeInputs = [
              pkgs.coreutils
              pkgs.git
              pkgs.gnugrep
            ];
            text = ''
              project_root="$PWD"
              exclude_file=""
              if git_root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
                project_root="$git_root"
                exclude_file="$(git rev-parse --git-path info/exclude)"
              else
                echo "warning: not in a Git repository; skipped git exclude" >&2
              fi

              target="$project_root/.agents/skills/maan2003-skills"
              source="${skills}/share/agents/skills"

              mkdir -p "$(dirname "$target")"

              if [ -e "$target" ] && [ ! -L "$target" ]; then
                echo "error: $target exists and is not a symlink" >&2
                exit 1
              fi

              ln -sfn "$source" "$target"

              if [ -n "$exclude_file" ]; then
                mkdir -p "$(dirname "$exclude_file")"
                touch "$exclude_file"
                pattern="/.agents/skills/maan2003-skills"
                if ! grep -Fxq "$pattern" "$exclude_file"; then
                  printf '\n%s\n' "$pattern" >> "$exclude_file"
                fi
              fi
            '';
          };

          default = skills;
        }
      );
    };
}
