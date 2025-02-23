{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    deno
  ];

  shellHook = ''
    clear  # Clear the terminal before displaying anything

    # Define the path to the Deno logo
    IMAGE_PATH=~/tedius-os/Assets/deno.png

    # Print the Deno logo on the left
    chafa "$IMAGE_PATH" -c 16 --dither bayer --dither-grain 4 --dither-intensity 3.0
    sleep 0.5  # Give time for image to render

    # Define the column position for text (adjust as needed)
    TEXT_COL=26

    # Capture and format Deno version information
    DENO_VERSION=$(deno --version | head -n 1| grep deno | awk '{print $2}')
    V8_VERSION=$(deno --version | grep v8 | awk '{print $2}')
    TS_VERSION=$(deno --version | grep typescript | awk '{print $2}')

    # Move cursor to display Deno version
    tput cup 2 $TEXT_COL
    echo -e "Deno Version: $DENO_VERSION"

    # Move cursor to display V8 version
    tput cup 3 $TEXT_COL
    echo -e "V8 Engine: $V8_VERSION"

    # Move cursor to display TypeScript version
    tput cup 4 $TEXT_COL
    echo -e "TypeScript: $TS_VERSION"

    # Add extra empty lines so the terminal prompt appears below everything
    ROW=13  # Adjust if more space is needed
    tput cup $ROW 0
  '';
}
