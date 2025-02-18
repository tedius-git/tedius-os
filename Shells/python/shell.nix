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
    echo -e "Python Version:$(python --version)"
    echo -e "Installed Packages:"
    pip list --format=columns | grep -Ev "pip|setuptools|wheel|pkg-resources|contourpy|cycler|fonttools|kiwisolver|packaging|pillow|pyparsing|python-dateutil|six"

  '';
}
