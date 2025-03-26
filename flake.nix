{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        crossPkgs = pkgs.pkgsCross.aarch64-multiplatform;
      in {
        devShell = pkgs.mkShellNoCC {
          buildInputs = with pkgs; [
            # tools
            bison
            flex
            swig
            gcc
            openssl
            gnutls
            dtc
            bc

            # python
            python3
            python3.pkgs.setuptools
            python3.pkgs.pyelftools
            python3.pkgs.cryptography

            # AArch64 cross toolchain (binaries: aarch64-unknown-linux-gnu-gcc, etc.)
            crossPkgs.buildPackages.binutils
            crossPkgs.buildPackages.gcc
          ];

          shellHook = ''
            export PS1="[🏗️ Projects] \u@\h:\w\$ "
          '';
        };
      }
    );
}