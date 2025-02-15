{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    deno
  ];

  shellHook = ''
    echo -e "Deno Version:$(deno --version)"
  '';
}
