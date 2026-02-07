{
  stdenvNoCC,
  fetchFromGitHub,
  imagemagick,
  segoe-ui,
  lucida-console,
  makeFontsConf
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-plymouthvista";
  version = "2026-02-04";
  src = fetchFromGitHub {
    owner = "furkrn";
    repo = "PlymouthVista";
    rev = "c659ea86484dca33f902e54ddc77437b78e4dea9";
    hash = "sha256-qSU4qni/Hcth8QlnjJhUHvtaNhoXTS089DiBjc8cuWY=";
  };

  env = {
    # https://discourse.nixos.org/t/fontconfig-error-no-writable-cache-directories/34447/2
    XDG_CACHE_HOME = "$(mktemp -d)";
    # https://discourse.nixos.org/t/imagemagicks-convert-command-fails-due-to-fontconfig-error/20518/5
    FONTCONFIG_FILE = makeFontsConf {
      fontDirectories = [ segoe-ui ];
    };
  };
  nativeBuildInputs = [ imagemagick ];
  buildPhase = ''
    runHook preBuild
    patchShebangs ./compile.sh ./pv_conf.sh ./gen_blur.sh

    ./compile.sh
    ./gen_blur.sh

    # Apply the setting swaps that install.sh does when activating
    # Windows 7 mode. Ideally I would allow the consumer to change
    # the config themselves, but it's unclear to me how I would do
    # so right now, since the config is baked in at build time.
    ./pv_conf.sh -s UseLegacyBootScreen -v 0
    ./pv_conf.sh -s UseShadow -v 1
    ./pv_conf.sh -s AuthuiStyle -v 7

    substituteInPlace PlymouthVista.plymouth \
      --replace-fail "/usr/share" "$out/share"

    mkdir -p $out/share/plymouth/themes/PlymouthVista
    cp -r images PlymouthVista.plymouth PlymouthVista.script \
      $out/share/plymouth/themes/PlymouthVista

    runHook postBuild
  '';
}