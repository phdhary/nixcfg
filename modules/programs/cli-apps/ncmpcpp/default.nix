{
  pkgs,
  config,
  namespace,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (config.home) homeDirectory;
  cfg = config.${namespace}.programs.cli-apps.ncmpcpp;
in {
  options.${namespace}.programs.cli-apps.ncmpcpp = {
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
      package = pkgs.ncmpcpp.override {visualizerSupport = true;};
      settings = {
        # mpd_host = "127.0.0.1";
        # mpd_port = "6601";
        song_columns_list_format = "(25)[cyan]{a} (40)[]{f} (30)[red]{b} (7f)[green]{l}";
        visualizer_in_stereo = "yes";
        # visualizer_data_source = "/tmp/mpd.fifo";
        # visualizer_output_name = "my_fifo";
        visualizer_type = "spectrum";
        visualizer_look = "●▮";
        visualizer_color = "red";
        playlist_shorten_total_times = "yes";
        playlist_display_mode = "columns";
        playlist_editor_display_mode = "columns";
        user_interface = "alternative";
        lines_scrolled = "1";
        mouse_list_scroll_whole_page = "yes";
        browser_display_mode = "columns";
        search_engine_display_mode = "columns";
        locked_screen_width_part = "60";
        message_delay_time = "3";
        use_console_editor = "yes";
        external_editor = "nvim";
        main_window_color = "white";
        current_item_prefix = "$(white)$r";
        header_window_color = "blue";
        volume_color = "red";
        player_state_color = "red:b";
        progressbar_color = "black";
        progressbar_elapsed_color = "magenta";
        progressbar_look = "─╼";
        now_playing_prefix = " ";
        autocenter_mode = "yes";
        centered_cursor = "yes";
        display_bitrate = "yes";
        enable_window_title = "yes";
        follow_now_playing_lyrics = "yes";
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
          command = ["move_selected_items_down"];
        }
        {
          key = "K";
          command = ["move_selected_items_up"];
        }
        {
          key = "L";
          command = "show_lyrics";
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
          key = "ctrl-e";
          command = "move_end";
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
          command = ["delete_browser_items" "delete_playlist_items" "delete_stored_playlist"];
        }
        {
          key = "f";
          command = "apply_filter";
        }
        {
          key = "h";
          command = ["previous_column" "jump_to_parent_directory"];
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
          command = ["next_column" "enter_directory" "play_item" "run_action"];
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
          key = "space";
          command = "select_item";
        }
        {
          key = "t";
          command = "move_home";
        }
        {
          key = "down";
          command = "scroll_down";
        }
        {
          key = "up";
          command = "scroll_up";
        }
      ];
    };

    xdg.desktopEntries."my.dude.ncmpcpp" = {
      name = "ncmpcpp";
      comment = "ncmpcpp cli app";
      icon = "io.bassi.Amberol";
      exec = "launch-ncmpcpp";
      categories = ["AudioVideo" "Music" "Audio" "ConsoleOnly"];
      terminal = true;
    };
  };
}
