{ pkgs ? import <nixpkgs> {} }:
let 
  project = import ./default.nix {};
in
pkgs.mkShell {
  name = "tpcdiscordbot-env";
  shellHook = ''
#    export NIX_GHC="$(which ghc)"
#    export NIX_GHCPKGS="$(which ghc-pkg)"
    export NIX_GHC_LIBDIR="$(ghc --print-libdir)"
  '';
  buildInputs = project.env.nativeBuildInputs ++ (with pkgs; [ cabal2nix haskellPackages.hpack haskellPackages.cabal-install haskellPackages.ghcide ]);
}
