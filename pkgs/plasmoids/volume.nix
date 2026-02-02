{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-volume";
  version = "2025-07-05";
  src = aerothemeplasma;

  preConfigure = "cd plasma/plasmoids/src/volume_src";
  buildInputs = [ kdePackages.libplasma ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
  postInstall = ''
    mkdir -p $out/share/plasma/plasmoids
    cp -r $src/plasma/plasmoids/io.gitgud.wackyideas.volume $out/share/plasma/plasmoids
  '';
}