{
  stdenv,
  lib,
  fetchFromGitLab,
  kdePackages,
  cmake,
  qt6,
}:
stdenv.mkDerivation {
  pname = "aeroglasspane";
  version = "2025-06-30";

  src = fetchFromGitLab {
    domain = "gitgud.io";
    owner = "wackyideas";
    repo = "aero-glass-pane";
    rev = "89401490368b03673d2ecff3a77b042438db5304";
    hash = "sha256-FOo70y56T+RnN1+og5hpW3SgQ2QIDb2PpyB6urCaTDI=";
  };

  buildInputs = [ qt6.qtbase kdePackages.kwindowsystem ];
  nativeBuildInputs = [ cmake qt6.wrapQtAppsHook ];

  meta = {
    mainProgram = "test";
  };
}