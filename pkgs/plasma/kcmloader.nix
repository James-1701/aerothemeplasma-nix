{
  stdenv,
  aerothemeplasma,
  kdePackages,
  pkg-config,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-kcmloader";
  version = "2026-02-03";
  src = aerothemeplasma;

  preConfigure = "cd plasma/aerothemeplasma-kcmloader";
  buildInputs = with kdePackages; [ kcmutils ];
  nativeBuildInputs = [ cmake pkg-config kdePackages.wrapQtAppsHook ];
}