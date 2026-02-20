{
  stdenv,
  lib,
  aerothemeplasma,
  plasma-workspace,
  kdePackages,
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
    substituteInPlace $out/bin/startatp-wayland \
      --replace-fail "$out/libexec/plasma-dbus-run-session-if-needed" "${plasma-workspace}/libexec/atplasma-dbus-run-session-if-needed" \
      --replace-fail "$out/bin/startplasma-wayland" "${plasma-workspace}/bin/startatplasma-wayland"

    # other packages are being built for wayland only,
    # so it's misleading to provide an x11 session
    rm -rf $out/bin/startatp $out/share/xsessions
  '';

  passthru.providedSessions = [ "aerothemeplasma" ];
}