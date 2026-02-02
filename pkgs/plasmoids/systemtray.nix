{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-systemtray";
  version = "2025-07-05";
  src = aerothemeplasma;

  preConfigure = "cd plasma/plasmoids/src/systemtray_src";
  buildInputs = with kdePackages; [
    libplasma qtwayland knotifyconfig
    kitemmodels kstatusnotifieritem
    plasma5support
  ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
}