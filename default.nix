{ pkgs ? import <nixpkgs> {}}:
pkgs.haskellPackages.callPackage ./tpcdiscordbot.nix {}
