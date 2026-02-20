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
  version = "2026-02-20";
  src = fetchFromGitHub {
    owner = "furkrn";
    repo = "PlymouthVista";
    rev = "b87f8c86cbf482b1414ebacb19e134e7c7b2d83a";
    hash = "sha256-2Jpr2oE+BsndJ+vAZk5o2UawuDTrEsrRauqrq4jkCVo=";
  };

  buildPhase = ''
    runHook preBuild
    patchShebangs ./compile.sh ./pv_conf.sh

    ./compile.sh

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