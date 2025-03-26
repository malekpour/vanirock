{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShell = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [
            git-repo
            gcc
          ];

          shellHook = ''
            export PS1="[🏗️ Projects] \u@\h:\w\$ "
          '';
        };
      }
    );
}