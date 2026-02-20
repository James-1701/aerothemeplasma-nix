{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-kcmloader";
  version = "2025-07-14";
  src = aerothemeplasma;

  preConfigure = "cd plasma/aerothemeplasma-kcmloader";
  buildInputs = with kdePackages; [ kcmutils ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
}