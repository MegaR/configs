{ config, pkgs, ... }:

{
  home.username = "rachel";
  home.homeDirectory = "/home/rachel";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    rustc
    cargo

    neovim
    zellij
    ripgrep
    fzf
    imgcat
    gum
    yt-dlp
    jq
    eza
    bat
    xclip
    tokei
    dust
    dua
    dive

    kubectl
    kubelogin
    kubernetes-helm
    k9s
    azure-cli

    lazygit
    lazydocker
    oh-my-posh
    tmux
    zoxide
    gh
    gh-dash
    tig
    lastpass-cli

    nodejs_22
    nodePackages.typescript
   (pkgs.nodePackages.prettier.overrideAttrs (oldAttrs: { postInstall = oldAttrs.postInstall or "" + '' rm $out/LICENSE ''; }))

    bun
    ((pkgs.yarn.override { nodejs = null; }).overrideAttrs (oldAttrs: { meta.platforms = nodejs.meta.platforms; }))
    lua
    luajitPackages.luarocks

    unzip
    zip
    git
    isort
    black
    tree-sitter
    php
    php84Packages.composer

    openssl
    gcc
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
