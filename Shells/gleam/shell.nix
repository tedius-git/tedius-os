{pkgs ? import <nixpkgs> {}}: let
  hs = pkgs.haskell.packages.ghc96; # Change ghc96 to another stable version if needed
in
  pkgs.mkShell {
    packages = with pkgs; [
      gleam
      erlang
    ];
    shellHook = ''
      clear  # Clear the terminal before displaying anything

      # Define the path to the Python logo
      IMAGE_PATH=~/tedius-os/Assets/gleam.png

      # Print the Python logo on the left
      chafa "$IMAGE_PATH"
      sleep 0.5  # Give time for image to render

      # Define the column position for text (adjust as needed)
      TEXT_COL=15

      # Move cursor to display Python version
      tput cup 2 $TEXT_COL
      echo -e "Gleam Version: $(gleam --version)"

      # Move cursor to display Installed Packages title
      tput cup 4 $TEXT_COL

      ROW=5 
      ROW=$((ROW + 5))  # Adjust if more space is needed
      tput cup $ROW 0
    '';
  }
