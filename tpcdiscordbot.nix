{ mkDerivation, base, discord-haskell, hpack, stdenv, text }:
mkDerivation {
  pname = "tpcdiscordbot";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [ base discord-haskell text ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [ base discord-haskell text ];
  testHaskellDepends = [ base discord-haskell text ];
  prePatch = "hpack";
  homepage = "https://github.com/githubuser/tpcdiscordbot#readme";
  license = stdenv.lib.licenses.bsd3;
}
