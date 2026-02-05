{
  stdenv,
  lib,
  aerothemeplasma,
  kdePackages,
  libplasma,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-login-session";
  version = "2025-10-25";
  src = aerothemeplasma;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ kdePackages.extra-cmake-modules ];
  preConfigure = "cd plasma/sddm/login-sessions";
  postFixup = ''
    sed -i '/export PLASMA_DEFAULT_SHELL/iexport LD_PRELOAD="${libplasma.out}/lib/libATPlasmaQuick.so ${libplasma.out}/lib/qt-6/qml/io/gitgud/wackyideas/plasma/core/libcorebindingsplugin.so''${LD_PRELOAD:+ }''${LD_PRELOAD}"' $out/bin/startatp-wayland

    substituteInPlace $out/bin/startatp-wayland \
      --replace-fail "$out/libexec/plasma-dbus-run-session-if-needed" "${kdePackages.plasma-workspace}/libexec/plasma-dbus-run-session-if-needed" \
      --replace-fail "$out/bin/startplasma-wayland" "${kdePackages.plasma-workspace}/bin/startplasma-wayland"

    # other packages are being built for wayland only,
    # so it's misleading to provide an x11 session
    rm -rf $out/bin/startatp $out/share/xsessions
  '';

  passthru.providedSessions = [ "aerothemeplasma" ];
}