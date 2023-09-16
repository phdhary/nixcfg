{unstable, ...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
    package = unstable.starship;
    settings = {
      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_commit"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        # "$fill"
        # "$shell"
        "$line_break"
        "$character"
      ];
      fill.symbol = " ";
      git_branch.style = "bright-black";
      git_commit.style = "bright-black";
      git_status.style = "bright-black";
      git_state.style = "bright-black";
      username.format = "[$user]($style)@";
      cmd_duration.format = "[$duration]($style) ";
      hostname.format = "[$ssh_symbol$hostname]($style) in ";
      shell = {
        disabled = false;
        style = "bright-black";
      };
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      directory = {
        style = "blue";
        truncate_to_repo = true;
        truncation_length = 8;
        # truncation_symbol = "../";
        # fish_style_pwd_dir_length = 1;
      };
    };
  };
}
