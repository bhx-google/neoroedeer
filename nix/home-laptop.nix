{ config, pkgs, ... }:

let nixgl = import <nixgl> { };
in {
  home.packages = [
    pkgs.neovim
    pkgs.alacritty
    nixgl.auto.nixGLDefault
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bhx";
  home.homeDirectory = "/home/bhx";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    userName = "Bill Xing";
    userEmail = "bhx@google.com";
    extraConfig = {
        core = {
            editor = "nvim";
        };
    };
  };

  home.sessionVariables = {
    PATH = "$HOME/local/bin:$PATH";
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git"];
      theme = "robbyrussell";
    };
    history = {
        size = 100000;
    };
    initExtra = ''
        if [ -e /usr/local/google/home/bhx/.nix-profile/etc/profile.d/nix.sh ];
        then
            . /usr/local/google/home/bhx/.nix-profile/etc/profile.d/nix.sh;
        fi # added by Nix installer

        if [ -e /etc/bash_completion.d/hgd ];
        then
            source /etc/bash_completion.d/hgd

            source $HOME/dotfiles/zsh/zsh-async/async.zsh
            source $HOME/dotfiles/zsh/goog_prompt.zsh
            source $HOME/dotfiles/zsh/goog_prompt_customize.zsh
        fi # source hgd
    '';
  };
}
