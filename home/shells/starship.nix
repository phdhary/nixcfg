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
        "$fill"
        "$shell"
        "$line_break"
        "$character"
      ];
      shell = {
        disabled = false;
        style = "bright-black";
      };
      fill.symbol = " ";
      username.format = "[$user]($style)@";
      hostname.format = "[$ssh_symbol$hostname]($style) in ";
      directory = {
        style = "blue";
        truncate_to_repo = false;
        truncation_length = 2;
        truncation_symbol = "../";
        fish_style_pwd_dir_length = 1;
      };
      character = {
        success_symbol = "[❯](purple)";
        error_symbol = "[❯](red)";
        vimcmd_symbol = "[❮](green)";
      };
      cmd_duration.format = "[$duration]($style) ";
      git_branch.style = "bright-black";
      git_commit.style = "bright-black";
      git_status.style = "cyan";
      git_state.style = "bright-black";
    };
  };
}
