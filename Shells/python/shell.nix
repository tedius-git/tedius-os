{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    (pkgs.python3.withPackages (p:
      with p; [
        pip # only for seeing installed packages, not for installing
        numpy
        matplotlib
      ]))
  ];

  shellHook = ''
    echo -e "\033[1;34m========================================\033[0m"
    echo -e "\033[1;32mPython Version:\033[0m \033[1;33m$(python --version)\033[0m"
    echo -e "\033[1;34m========================================\033[0m"
    echo -e "\033[1;32mInstalled Packages:\033[0m"
    pip list --format=columns | grep -Ev "pip|setuptools|wheel|pkg-resources|contourpy|cycler|fonttools|kiwisolver|packaging|pillow|pyparsing|python-dateutil|six"
    echo -e "\033[1;34m========================================\033[0m"
  '';
}
