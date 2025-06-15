{
  description = "Nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, config, lib, ... }: {


      # Allow closed source applications
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        # nix packages only for macos
        pkgs.mkalias
        pkgs.raycast
      ];

      # Homebrew packages
      homebrew = {
        enable = true;
        # homebrew packages
        brews = [
          # look up appstore ids with `mas search X`
          "mas"
          # "koekeishiya/formulae/skhd"
        ];
        # homebrew casks
        casks = [
          "google-chrome"
          "wezterm"
          "microsoft-auto-update"
          "microsoft-teams"
          "microsoft-outlook"
          "microsoft-word"
          "microsoft-excel"
          "onedrive"
          "docker"
          "parsec"
          "visual-studio-code"
          "bruno"
          "betterdisplay"
        ];
        # appstore packages
        masApps = {
          # "name" = appstore_id
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      fonts.packages = [
        pkgs.monaspace
      ];

      # fix spotlight search for applications
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        lib.mkForce ''
          # Set up applications.
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read -r src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      #system settings
      system.defaults = {
        NSGlobalDomain = {
          AppleInterfaceStyle = "Dark";
          AppleShowAllExtensions = true;

        };
        dock.autohide = true;
        dock.minimize-to-application = true;
        dock.persistent-apps = [
          "/Applications/WezTerm.app"
          "/Applications/Google Chrome.app"
          "/Applications/Microsoft Teams.app"
          "/Applications/Microsoft Outlook.app"
        ];
        dock.persistent-others = [
          "/Users/rachel/Downloads"
          "/Users/rachel/zintouch"
        ];
        dock.show-recents = false;

        #default finder to column view
        finder.FXPreferredViewStyle = "clmv";
        finder.AppleShowAllExtensions = true;
        finder.AppleShowAllFiles = true;
        finder.QuitMenuItem = true;
        finder.ShowPathbar = true;
        loginwindow.GuestEnabled = false;
        NSGlobalDomain.AppleICUForce24HourTime = true;
      };
      system.keyboard.enableKeyMapping = true;

      services = {
        skhd = {
          enable = true;
          skhdConfig = ''
            alt - c : open -a 'WezTerm'
            alt - b : open -a 'Google Chrome'
            alt - t : open -a 'Microsoft Teams'
            alt - m : open -a 'Microsoft Outlook'
          '';
        };
        sketchybar = {
          enable = true;
          config = ''
# This is a demo config to showcase some of the most important commands.
# It is meant to be changed and configured, as it is intentionally kept sparse.
# For a (much) more advanced configuration example see my dotfiles:
# https://github.com/FelixKratz/dotfiles

PLUGIN_DIR="$CONFIG_DIR/plugins"

##### Bar Appearance #####
# Configuring the general appearance of the bar.
# These are only some of the options available. For all options see:
# https://felixkratz.github.io/SketchyBar/config/bar
# If you are looking for other colors, see the color picker:
# https://felixkratz.github.io/SketchyBar/config/tricks#color-picker

sketchybar --bar position=top height=40 blur_radius=30 color=0x40000000

##### Changing Defaults #####
# We now change some default values, which are applied to all further items.
# For a full list of all available item properties see:
# https://felixkratz.github.io/SketchyBar/config/items

default=(
  padding_left=5
  padding_right=5
  # icon.font="Hack Nerd Font:Bold:17.0"
  # label.font="Hack Nerd Font:Bold:14.0"
  icon.color=0xffffffff
  label.color=0xffffffff
  icon.padding_left=4
  icon.padding_right=4
  label.padding_left=4
  label.padding_right=4
)
sketchybar --default "$\{default[@]}"

##### Adding Mission Control Space Indicators #####
# Let's add some mission control spaces:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item
# to indicate active and available mission control spaces.

# SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10")
# for i in "$\{!SPACE_ICONS[@]}"
# do
#   sid="$(($i+1))"
#   space=(
#     space="$sid"
#     icon="$\{SPACE_ICONS[i]}"
#     icon.padding_left=7
#     icon.padding_right=7
#     background.color=0x40ffffff
#     background.corner_radius=5
#     background.height=25
#     label.drawing=off
#     script="$PLUGIN_DIR/space.sh"
#     click_script="yabai -m space --focus $sid"
#   )
#   sketchybar --add space space."$sid" left --set space."$sid" "$\{space[@]}"
# done
#
# ##### Adding Left Items #####
# # We add some regular items to the left side of the bar, where
# # only the properties deviating from the current defaults need to be set
#
# sketchybar --add item chevron left \
#            --set chevron icon= label.drawing=off \
#            --add item front_app left \
#            --set front_app icon.drawing=off script="$PLUGIN_DIR/front_app.sh" \
#            --subscribe front_app front_app_switched
#
# ##### Adding Right Items #####
# # In the same way as the left items we can add items to the right side.
# # Additional position (e.g. center) are available, see:
# # https://felixkratz.github.io/SketchyBar/config/items#adding-items-to-sketchybar
#
# # Some items refresh on a fixed cycle, e.g. the clock runs its script once
# # every 10s. Other items respond to events they subscribe to, e.g. the
# # volume.sh script is only executed once an actual change in system audio
# # volume is registered. More info about the event system can be found here:
# # https://felixkratz.github.io/SketchyBar/config/events
#
# sketchybar --add item clock right \
#            --set clock update_freq=10 icon=  script="$PLUGIN_DIR/clock.sh" \
#            --add item volume right \
#            --set volume script="$PLUGIN_DIR/volume.sh" \
#            --subscribe volume volume_change \
#            --add item battery right \
#            --set battery update_freq=120 script="$PLUGIN_DIR/battery.sh" \
#            --subscribe battery system_woke power_source_change

##### Force all scripts to run the first time (never do this in a script) #####
sketchybar --update
          '';
        };
      };

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.zsh.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."rachel" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "rachel";
          };
        }
        home-manager.darwinModules.home-manager
        {
          users.users.rachel.home = nixpkgs.lib.mkForce "/Users/rachel";
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rachel = import ../home-manager/home.nix;
        }
      ];
    };

    # ??
    darwinPackages = self.darwinConfigurations."rachel".pkgs;
  };
}

# nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/.config/nix-darwin#rachel
# to update nix flake update
# darwin-rebuild switch --flake ~/.config/nix-darwin#rachel
