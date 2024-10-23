{pkgs,lib,...}:{

  # setup terminal emulator
  programs.foot = {
    enable = true;
    package = pkgs.foot;
    settings = {
      main = { font = "gohufont:size=12"; };
      mouse = { hide-when-typing = "yes"; };
      colors = {
        background="1C1C1C"; 
        foreground="e0def4";
        regular0="26233a";   # black
        regular1="eb6f92";   # red
        regular2="31748f";   # green
        regular3="f6c177";   # yellow
        regular4="9ccfd8";   # blue
        regular5="c4a7e7";   # magenta
        regular6="ebbcba";   # cyan
        regular7="e0def4";   # white
        bright0="6e6a86";   # bright black
        bright1="eb6f92";    # bright red
        bright2="31748f";    # bright green
        bright3="f6c177";    # bright yellow
        bright4="9ccfd8";    # bright blue
        bright5="c4a7e7";    # bright magenta
        bright6="ebbcba";    # bright cyan
        bright7="e0def4";    # bright white
      };
    };
  };

  # custom prompt
  programs.starship = { 
    package = pkgs.starship;
    enable = true;
    enableZshIntegration = true;
    enableTransience = true;
    settings = {
      add_newline = true;
      format = lib.concatStrings [
        "$all"
        "$line_break"
        "$character"
        "$directory"
      ];
      scan_timeout = 10;
      character = {
        success_symbol = " 󱄅 ";
        error_symbol = " 󱄅 ";
      };
      directory = {
        read_only = " ";
        home_symbol = "~";
      };
    };
  };

  programs.zsh = {

    # enable zsh and some default plugins
    package = pkgs.zsh;
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # ohmyzsh plugins
    oh-my-zsh = {
      package = pkgs.oh-my-zsh;
      enable = true;
      plugins = [
        "git"
      ];
    };

    # manage history
    history = {
      size = 10000;
      ignoreAllDups = true;
      path = "$HOME/.zsh_history";
      ignorePatterns = [
        "rebuild"
        "pkill *"
        "clear"
        "exit"
        "c"
        "e"
        "p"
        "s"
        "b"
      ];
    };

  };

  # zoxide for "z" command
  programs.zoxide = {
    enable = true;
    package = pkgs.zoxide;
    enableZshIntegration = true;
  };

}
