{ config, namespace, lib, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.home) homeDirectory;
  cfg = config.${namespace}.programs.ncmpcpp;
in {
  options.${namespace}.programs.ncmpcpp = {
    enable = mkEnableOption "ncmpcpp";
  };

  config = mkIf cfg.enable {
    services.mpd = {
      enable = true;
      musicDirectory = "${homeDirectory}/Music";
      extraConfig = ''
        auto_update "yes"
      '';
    };

    programs.ncmpcpp = {
      enable = true;
      settings = {
        allow_for_physical_item_deletion = "no";
        autocenter_mode = "yes";
        browser_display_mode = "columns";
        centered_cursor = "yes";
        current_item_prefix = "$(white)$r";
        display_bitrate = "yes";
        enable_window_title = "yes";
        external_editor = "nvim";
        follow_now_playing_lyrics = "yes";
        header_window_color = "blue";
        lines_scrolled = 1;
        locked_screen_width_part = 60;
        main_window_color = "white";
        message_delay_time = 3;
        mouse_list_scroll_whole_page = "yes";
        mpd_crossfade_time = 3;
        now_playing_prefix = " ";
        player_state_color = "red:b";
        playlist_display_mode = "columns";
        playlist_editor_display_mode = "columns";
        playlist_shorten_total_times = "yes";
        progressbar_color = "black";
        progressbar_elapsed_color = "magenta";
        progressbar_look = "─╼";
        search_engine_display_mode = "columns";
        song_columns_list_format =
          "(25)[cyan]{a} (40)[]{f} (30)[red]{b} (7f)[green]{l}";
        use_console_editor = "yes";
        user_interface = "alternative";
        volume_color = "red";
      };
      bindings = [
        {
          key = "*";
          command = "toggle_visualization_type";
        }
        {
          key = "+";
          command = "show_clock";
        }
        {
          key = "=";
          command = "volume_up";
        }
        {
          key = "C";
          command = "toggle_playing_song_centering";
        }
        {
          key = "J";
          command = "move_selected_items_down";
        }
        {
          key = "K";
          command = "move_selected_items_up";
        }
        {
          key = "L";
          command = "show_lyrics";
        }
        {
          key = "down";
          command = "scroll_down";
        }
        {
          key = "up";
          command = "scroll_up";
        }
        {
          key = "ctrl-a";
          command = "add_item_to_playlist";
        }
        {
          key = "ctrl-b";
          command = "page_up";
        }
        {
          key = "ctrl-d";
          command = "page_down";
        }
        {
          key = "ctrl-f";
          command = "page_down";
        }
        {
          key = "ctrl-u";
          command = "page_up";
        }
        {
          key = "d";
          command = "delete_browser_items";
        }
        {
          key = "d";
          command = "delete_playlist_items";
        }
        {
          key = "d";
          command = "delete_stored_playlist";
        }
        {
          key = "F";
          command = "apply_filter";
        }
        {
          key = "h";
          command = "previous_column";
        }
        {
          key = "h";
          command = "jump_to_parent_directory";
        }
        {
          key = "j";
          command = "scroll_down";
        }
        {
          key = "k";
          command = "scroll_up";
        }
        {
          key = "l";
          command = "next_column";
        }
        {
          key = "l";
          command = "enter_directory";
        }
        {
          key = "l";
          command = "play_item";
        }
        {
          key = "l";
          command = "run_action";
        }
        {
          key = "n";
          command = "next_found_item";
        }
        {
          key = "N";
          command = "previous_found_item";
        }
        {
          key = "t";
          command = "move_home";
        }
        {
          key = "ctrl-e";
          command = "move_end";
        }
        {
          key = "space";
          command = "select_item";
        }
      ];
    };

    xdg.desktopEntries."my.dude.ncmpcpp" = {
      name = "ncmpcpp";
      comment = "ncmpcpp cli app";
      icon = "io.bassi.Amberol";
      exec = "ncmpcpp";
      categories = [ "AudioVideo" "Music" "Audio" "ConsoleOnly" ];
      terminal = true;
    };
  };
}
