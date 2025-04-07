{pkgs, ...}: {
  home.packages = with pkgs; [
    # minecraft is marked as broken
    prismlauncher
  ];
}
