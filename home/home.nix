{ config, pkgs,   ... }:
let

  pkgsUnstable = import <nixpkgs-unstable> {};

in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "pub";
  home.homeDirectory = "/home/pub";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  fonts.fontconfig.enable = true;
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    (pkgs.nerdfonts.override { fonts = [
                                 "FantasqueSansMono"
                                 "JetbrainsMono"
                               ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    pkgsUnstable.emacs29-pgtk
    #pkgsUnstable.emacsGcc
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
     ".emacs.d".source = ~/.config/emacs.d/init.el;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/pub/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
     EDITOR = "emacs";
  };
  #services.foot.enable = true;
  programs.foot =
    {
      enable = true;
      settings = {
        main = {
            term = "xterm-256color";

    font = "Jetbrains-Mono:size=11";
    dpi-aware = "yes";
  };

  mouse = {
    hide-when-typing = "yes";
  };
      };
    };
  programs.foot.server.enable = true;
  services.emacs.enable = true;
   services.emacs.package = pkgs.emacs29-pgtk;
  #services.emacs.package = with pkgs; ((emacsPackagesFor emacsPgtkNativeComp).emacsWithPackages (epkgs: [ epkgs.mu4e ]));
   manual.manpages.enable = false;
   manual.html.enable = false;
   manual.json.enable = false;
  # Let Home Manager install and manage itself.
   programs.home-manager.enable = true;
}
