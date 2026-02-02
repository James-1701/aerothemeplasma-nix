{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-notifications";
  version = "2025-10-27";
  src = aerothemeplasma;

  preConfigure = "cd plasma/plasmoids/src/notifications_src";
  buildInputs = with kdePackages; [
    plasma-workspace
  ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
}