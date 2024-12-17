{ config, pkgs, ... }:

{
  home.packages = [
    pkgs.neovim
    pkgs.cmake
    pkgs.htop
    pkgs.rustup
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "bhx";
  home.homeDirectory = "/usr/local/google/home/bhx";

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
        bindkey '^R' history-incremental-pattern-search-backward;
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

  home.file.initvim = {
    enable = true;
    source = "/usr/local/google/home/bhx/dotfiles/nvim/init.vim";
    target = "/usr/local/google/home/bhx/.config/nvim/init.vim";
  };
  home.file.ciderlsp = {
    enable = true;
    source = "/usr/local/google/home/bhx/dotfiles/nvim/lua/lsp.lua";
    target = "/usr/local/google/home/bhx/.config/nvim/lua/lsp.lua";
  };
  home.file.diagnostics = {
    enable = true;
    source = "/usr/local/google/home/bhx/dotfiles/nvim/lua/diagnostics.lua";
    target = "/usr/local/google/home/bhx/.config/nvim/lua/diagnostics.lua";
  };
  home.file.tmux = {
    enable = true;
    source = "/usr/local/google/home/bhx/dotfiles/tmux/.tmux.conf";
    target = "/usr/local/google/home/bhx/.tmux.conf";
  };
  home.file.get_window = {
    enable = true;
    source = "/usr/local/google/home/bhx/dotfiles/scripts/get_window.sh";
    target = "/usr/local/google/home/bhx/local/bin/get_window.sh";
  };
  home.file.piper_helper = {
    enable = true;
    source = "/usr/local/google/home/bhx/dotfiles/scripts/piper_helper.sh";
    target = "/usr/local/google/home/bhx/local/bin/piper_helper.sh";
  };
  home.file.hgrc = {
    enable = true;
    source = "/usr/local/google/home/bhx/dotfiles/google/.hgrc";
    target = "/usr/local/google/home/bhx/.hgrc";
  };
  home.file.blazerc = {
    enable = true;
    source = "/usr/local/google/home/bhx/dotfiles/google/.blazerc";
    target = "/usr/local/google/home/bhx/.blazerc";
  };

}
