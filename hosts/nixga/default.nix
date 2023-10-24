# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  unstable,
  user,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    efi.canTouchEfiVariables = true;
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
  };

  nix = {
    package = pkgs.nixFlakes;
    settings.experimental-features = ["nix-command" "flakes"];
  };

  networking = {
    #hostName = "nixga"; # Define your hostname.
    # Pick only one of the below networking options.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.

    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    # useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;

    resolutions = [
      {
        x = 1920;
        y = 1080;
      }
    ];
    virtualScreen = {
      x = 1920;
      y = 1080;
    };

    displayManager.defaultSession = "none+i3";

    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        noDesktop = true;
        enableXfwm = false;
      };
    };

    windowManager = {
      i3 = {
        enable = true;
        extraPackages = with pkgs;
          [
            rofi
            i3status
            i3lock
          ]
          ++ [
            unstable.i3status-rust
          ];
      };
    };

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.enable = true;
    # Configure keymap in X11
    layout = "us";
    # xkbOptions = "eurosign:e,caps:escape";
  };

  nixpkgs.config.allowUnfree = true;

  fonts.fonts = with pkgs; [
    inter
    jetbrains-mono
    helvetica-neue-lt-std
    corefonts
    (nerdfonts.override {fonts = ["IBMPlexMono"];})
  ];

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.zsh;
    users.${user} = {
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager"];
      hashedPassword = "$6$hOT6BLGTRxKKMREL$3Us.X89g7700vqIcNLT0qJ7Xwnk4G3r3FcGwjhGIGb0JatRexsdZC6dfcMagd2cQTKg3dZoNorEn37t3BEijW1";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHkgc+eVwvz+i1nHJu5inGG7f+ncQBFFzWZPxid7KNFE phdhary@gmail.com"
      ];
    };
  };

  environment.systemPackages = with pkgs;
    [
      bat
      btop
      exa
      ncdu
      neofetch
      ranger
      ripgrep
      wezterm
      wget
      yt-dlp
			nixfmt
			wormhole-rs
    ]
    ++ [
      unstable.vim
    ];

  environment.variables = {
    EDITOR = "vim";
    VISUAL = "vim";
    PAGER = "bat";
    TERMINAL = "wezterm";
  };

  environment.shellAliases = {
    g = "git";
    l = "ls -la";
    ls = "exa --icons";
    ranger = ". ranger";
    rm = "rm -i";
  };

  programs = {
    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

		git = {
			enable = true;
			config = {
				init = { defaultBranch = "main"; };
        core = { autocrlf = "input"; };
				aliases = {
					unpushed = "log --oneline --decorate --graph origin/main^..main";
				};
				user = {
					email = "phdhary@gmail.com";
					name =  "phdhary";
				};
			};
		};

    zsh = {
      enable = true;
      histSize = 1000000;
      enableCompletion = true;
      enableBashCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        bindkey '^ ' autosuggest-accept
        bindkey '^f' forward-word
        zstyle ':completion:*' menu select
        autoload -U promptinit && promptinit && prompt suse && setopt prompt_sp
      '';
    };
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  system.stateVersion = "23.05"; # Did you read the comment?
}
