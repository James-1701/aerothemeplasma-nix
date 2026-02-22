{
  stdenv,
  lib,
  fetchFromGitLab,
  qt6,
  kdePackages
}:
stdenv.mkDerivation {
  pname = "7sPhotoView";
  version = "bf1082eb";

  src = fetchFromGitLab {
    domain = "gitgud.io";
    owner = "snailatte";
    repo = "7s-photoview";
    rev = "bf1082ebce479633541d40ea94de416163f846f1";
    sha256 = "sha256-kwXAe/bka8mkZ11b7EEWZC7dz7zart6rmzLyDrJ1zuE=";
  };

  buildInputs = [ qt6.qtbase kdePackages.kwindowsystem ];
  nativeBuildInputs = [ qt6.wrapQtAppsHook qt6.qmake ];

  qmakeFlags = [
    "photoview.pro"
    "INCLUDEPATH+=${kdePackages.kwindowsystem.dev}/include/KF6/KWindowSystem"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons

    cp -R ./installation/hicolor $out/share/icons
    sed "s|~/.local|$out|g" ./installation/photoview.desktop > $out/share/applications/photoview.desktop
    cp -f ./photoview $out/bin
    runHook postInstall
  '';
}