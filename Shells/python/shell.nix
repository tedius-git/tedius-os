{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (p:
      with p; [
        pip # only for seeing installed packages, not for installing
        numpy
        sympy
        matplotlib
      ]))
  ];

  shellHook = ''
        clear  # Clear the terminal before displaying anything

    # Define the path to the Python logo
    IMAGE_PATH=~/tedius-os/Assets/python.png

    # Print the Python logo on the left
    chafa "$IMAGE_PATH"
    sleep 0.5  # Give time for image to render

    # Define the column position for text (adjust as needed)
    TEXT_COL=25

    # Move cursor to display Python version
    tput cup 2 $TEXT_COL
    echo -e "Python Version: $(python --version | cut -d' ' -f2)"

    # Move cursor to display Installed Packages title
    tput cup 4 $TEXT_COL
    echo -e "Installed Packages:"

    # Capture pip output and print each line at the correct position
    ROW=5  # Start listing packages from row 5
    pip list --format=columns | grep -Ev "pip|setuptools|wheel|pkg-resources|contourpy|cycler|fonttools|kiwisolver|packaging|pillow|pyparsing|python-dateutil|six" | while IFS= read -r line
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
