{pkgs ? import <nixpkgs> {}}: let
  hs = pkgs.haskell.packages.ghc96; # You can change ghc96 to another stable version
in
  pkgs.mkShell {
    buildInputs = [
      hs.ghc
      hs.haskell-language-server
      hs.cabal-install
    ];

    shellHook = ''
      echo "Haskell environment ready with GHC $(ghc --version) and HLS $(haskell-language-server --version)"
    '';
  }
