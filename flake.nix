{
  description = "Advent of Code";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    git-hooks.url = "github:cachix/git-hooks.nix";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, rust-overlay, git-hooks, ... }: let
    supportedSystems = [ "x86_64-linux" ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    overlays = [ (import rust-overlay) ];
    pkgs = system: import nixpkgs {
      inherit system overlays;
    };
    rust = system: (pkgs system).rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
  in {
    checks = forAllSystems (system: {
      pre-commit = git-hooks.lib.${system}.run {
        src = ./.;
        hooks = import ./.pre-commit-config.nix { pkgs = nixpkgs.legacyPackages.${system}; };
      };
    });

    devShells = forAllSystems (system: {
      default = (pkgs system).mkShell {
        inherit (self.checks.${system}.pre-commit) shellHook;
        name = "AdventOfCode2024";
        buildInputs = with pkgs system; [
          just
          (rust system)
        ] ++ self.checks.${system}.pre-commit.enabledPackages;
        JUST_COMMAND_COLOR = "blue";
      };
    });
  };
}
