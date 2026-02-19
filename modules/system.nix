perSystem:
{ config, lib, pkgs, ... }:
let
  cfg = config.aerothemeplasma;
  atpkgs = perSystem.config.packages;
in
{
  options.aerothemeplasma = {
    enable = lib.mkEnableOption "the AeroThemePlasma system components";
    plasma.enable = lib.mkEnableOption "the AeroThemePlasma theme packages";
    fonts.enable = lib.mkEnableOption "the Segoe UI and Lucida Console fonts";
    plymouth.enable = lib.mkEnableOption "the PlymouthVista theme";
    sddm.enable = lib.mkEnableOption "the SDDM theme";
  };

  config = lib.mkIf cfg.enable {
    assertions = [{
      assertion = cfg.plymouth.enable -> cfg.fonts.enable;
      message = "The PlymouthVista theme requires AeroThemePlasma fonts to be enabled.";
    }];

    services.displayManager.sessionPackages = [ atpkgs.login-session ];
    environment.systemPackages = [
      pkgs.kdePackages.qtmultimedia # used by shell and sddm
      (lib.lowPrio atpkgs.plasma-workspace)
      atpkgs.cursors # used by sddm, haven't found a better way to pass it
    ] ++ lib.optionals cfg.fonts.enable [
      atpkgs.segoe-ui
      atpkgs.lucida-console
    ] ++ (with atpkgs; lib.optionals cfg.plasma.enable [
      icons sounds

      authui7 color-scheme kvantum-windows7aero
      layout-template seven-black

      keyboardlayout win7showdesktop
      seventasks sevenstart aeroglassblur
      shell smod smodglow desktopcontainment
      systemtray notifications volume flip3d
      digitalclocklite panel thumbnail-seven
      fadingpopupsaero squashaero loginaero
      dimscreenaero launchfeedback smodsnap
      aeroglide kcmloader

      pkgs.kdePackages.qtstyleplugin-kvantum
      libplasma
    ]);

    boot.plymouth = lib.mkIf cfg.plymouth.enable {
      theme = "PlymouthVista";
      themePackages = [ atpkgs.plymouthvista ];
    };

    services.displayManager.sddm = lib.mkIf cfg.sddm.enable {
      theme = "${atpkgs.sddm-theme-mod}/share/sddm/themes/sddm-theme-mod";
      extraPackages = [ pkgs.kdePackages.kitemmodels ];
      settings = {
        Theme = {
          CursorTheme = "aero-drop";
          CursorSize = 30;
          Font = lib.mkIf cfg.fonts.enable "Segoe UI";
        };
      };
    };
  };
}
