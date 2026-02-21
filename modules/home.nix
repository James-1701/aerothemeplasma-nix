perSystem:
{ config, lib, pkgs, ... }:
let
  cfg = config.aerothemeplasma;
  atpkgs = perSystem.config.packages;
in
{
  options.aerothemeplasma = {
    enable = lib.mkEnableOption "the AeroThemePlasma home components";
    plasma.enable = lib.mkEnableOption "the AeroThemePlasma theme";
    fonts = {
      enable = lib.mkEnableOption "the system's Segoe UI and Lucida Console fonts";
      size = lib.mkOption {
        description = "The primary point size of the Segoe UI font.";
        type = lib.types.ints.positive;
        default = 9;
      };
    };
    soundTheme = lib.mkOption {
      description = "The sound theme to enable.";
      type = lib.types.enum [
        "Afternoon" "Calligraphy" "Characters"
        "Cityscape" "Delta" "Default" "Festival"
        "Garden" "Heritage" "Landscape" "Quirky"
        "Raga" "Savanna" "Sonata"
      ];
      example = "Sonata";
      default = "Default";
    };
  };
  options.programs.linver.enable = lib.mkEnableOption "the Linver application and its KWin rule";

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = config.programs.plasma.panels == [];
        message = "programs.plasma.panels is set, which will clobber AeroThemePlasma's panel.";
      }
      {
        assertion = !config.programs.plasma.overrideConfig;
        message = "programs.plasma.overrideConfig is set, which will clobber AeroThemePlasma's panel.";
      }
    ];

    home.packages = (with atpkgs; lib.optionals cfg.plasma.enable [
      cursors icons sounds

      authui7 color-scheme kvantum-windows7aero
      layout-template seven-black

      keyboardlayout win7showdesktop
      seventasks sevenstart aeroglassblur
      shell smod smodglow desktopcontainment
      systemtray notifications volume flip3d
      digitalclocklite panel thumbnail-aero
      fadingpopupsaero squashaero loginaero
      dimscreenaero launchfeedback smodsnap
      aeroglide kcmloader

      pkgs.kdePackages.qtstyleplugin-kvantum
      libplasma
    ]) ++ lib.optionals config.programs.linver.enable [ atpkgs.linver ];

    programs.plasma = lib.mkIf cfg.plasma.enable {
      workspace = {
        lookAndFeel = "authui7";
        soundTheme =
          if cfg.soundTheme == "Default" then "Windows 7"
          else "Windows 7 ${cfg.soundTheme}";
        cursor = {
          theme = "aero-drop";
          size = 32;
          cursorFeedback = "None";
        };
      };

      fonts = lib.mkIf cfg.fonts.enable rec {
        general = {
          family = "Segoe UI";
          pointSize = cfg.fonts.size;
        };
        toolbar = general;
        menu = general;
        windowTitle = general;
        small = {
          family = "Segoe UI";
          pointSize = cfg.fonts.size - 1;
        };
      };

      kwin.effects = {
        blur.enable = false;
        dimAdminMode.enable = false;
      };
      configFile.kwinrc = {
        MouseBindings.CommandWindow1 = "Activate, raise and pass click";
        Plugins = {
          fadingpopupsEnabled = false;
          dialogparentEnabled = false;
          loginEnabled = false; # "Fade to the desktop when logging in"
          logoutEnabled = false; # "Fade to the logout screen"
          maximizeEnabled = false; # "Stretch windows when they are maximized or restored"
          scaleEnabled = false;
          slideEnabled = false;
          slidingpopupsEnabled = false;
          windowapertureEnabled = false;

          aeroglideEnabled = true;
          aeroglassblurEnabled = true;
          dimscreenaeroEnabled = true;
          fadingpopupsaeroEnabled = true;
          libkwin_effect_smodsnapEnabled = true;
          loginaeroEnabled = true;
          squashaeroEnabled = true;
          smodglowEnabled = true;

          minimizeallEnabled = true;
        };
        TabBox.LayoutName = "thumbnail_aero";
        TabBoxAlternative.LayoutName = "flip3d";
      };
      configFile.kdeglobals.KDE = {
        AnimationDurationFactor = 1.414213562373095; # 8 steps from the left in "global animation speed"
      };

      shortcuts.kwin = {
        "Walk Through Windows" = "Alt+Tab";
        "Walk Through Windows Alternative" = "Meta+Tab";
      };

      window-rules = lib.mkIf config.programs.linver.enable [{
        description = "Hide non-close buttons for Linver";
        match.window-class = {
          value = "linver";
          match-whole = false;
        };
        apply.minimizerule.value = 2;
      }];
    };
  };
}
