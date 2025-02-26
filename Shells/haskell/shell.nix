{pkgs ? import <nixpkgs> {}}: let
  hs = pkgs.haskell.packages.ghc96; # Change ghc96 to another stable version if needed
in
  pkgs.mkShell {
    buildInputs = [
      hs.ghc
      hs.haskell-language-server
      hs.cabal-install
    ];

    shellHook = ''
        clear  # Clear the terminal before displaying anything

        # Define the path to the Haskell logo
        IMAGE_PATH=~/tedius-os/Assets/Haskell.png

        # Print the Haskell logo on the left
        chafa "$IMAGE_PATH" -c 8 --dither bayer
        sleep 0.5  # Give time for image to render

        # Define the column position for text (adjust as needed)
        TEXT_COL=40

        # Move cursor to display Haskell environment details
        tput cup 2 $TEXT_COL
        echo -e "GHC Version: $(ghc --version |  awk '{print $8}' )"

        tput cup 3 $TEXT_COL
        echo -e "HLS Version: $(haskell-language-server-wrapper --version | awk '{print $3}')"

        tput cup 4 $TEXT_COL
        echo -e "Installed Haskell Packages:"

        # Capture installed Haskell packages, filter out preinstalled ones, and print each line
        ROW=7  # Start listing packages from row 7
        ghc-pkg list | awk '
          BEGIN {show=0}
          /^\// {next}  # Ignore directory paths
          /^[ ]*$/ {next}  # Ignore empty lines
          /\(.*\)/ {next}  # Ignore package versions in parentheses
          /array|base|binary|bytestring|Cabal-syntax|containers|deepseq|directory|exceptions|filepath|ghc-bignum|ghc-boot|ghc-boot-th|ghc-compact|ghc-heap|ghci|ghc-prim|haskeline|hpc|integer-gmp|libiserv|mtl|parsec|pretty|process|rts|stm|system-cxx-std-lib|template-haskell|terminfo|text|time|transformers|unix|xhtml/ {next}  # Ignore default packages
          {print}
        ' | while IFS= read -r line
        do
          tput cup $ROW $TEXT_COL
          echo "$line"
          ROW=$((ROW+1))  # Move to the next row
        done
      # Add extra empty lines so the terminal prompt appears below everything
      ROW=$((ROW + 5))  # Adjust if more space is needed
      tput cup $ROW 0
    '';
  }
