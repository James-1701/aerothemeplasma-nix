{
  stdenv,
  fetchFromGitLab,
  kdePackages,
  qt6
}:
stdenv.mkDerivation {
  pname = "7s-explorer";
  version = "2026-01-03";

  src = fetchFromGitLab {
    domain = "gitgud.io";
    owner = "snailatte";
    repo = "7s-explorer";
    rev = "19191afb680f7a276c7f2c9058d4304e8cc4848c";
    sha256 = "sha256-1hIHZuBBcoAovRoQXeQ53VCEaUEXxQRYxKK9Pm+L2HE=";
  };

  buildInputs = with kdePackages; [ 
    qt6.qtbase qt6.qtmultimedia 
    kwindowsystem kservice kio kcoreaddons 
  ];
  nativeBuildInputs = [ qt6.wrapQtAppsHook qt6.qmake ];

  # Snaillatte hardcoded all the paths and it breaks compilation on nixos. This fixes it
  qmakeFlags = with kdePackages; [
    "explorer.pro"
    "INCLUDEPATH+=${kwindowsystem.dev}/include/KF6/KWindowSystem"
    "INCLUDEPATH+=${kservice.dev}/include/KF6/KService"
    "INCLUDEPATH+=${kio.dev}/include/KF6/KIO"
    "INCLUDEPATH+=${kio.dev}/include/KF6/KIOCore"
    "INCLUDEPATH+=${kcoreaddons.dev}/include/KF6/KCoreAddons"
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/applications
    mkdir -p $out/share/icons

    cp -R ./installation/hicolor $out/share/icons
    sed "s|~/.local|$out|g" ./installation/explorer.desktop > $out/share/applications/explorer.desktop
    cp -f ./explorer $out/bin
    runHook postInstall
  '';

  meta = {
    mainProgram = "explorer";
  };
}