{
  stdenv,
  lib,
  aerothemeplasma,
  kdePackages,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-login-sessions";
  version = "2025-10-25";
  src = aerothemeplasma;

  nativeBuildInputs = [ cmake ];
  buildInputs = [ kdePackages.extra-cmake-modules ];
  preConfigure = "cd plasma/sddm/login-sessions";
  postFixup = ''
    substituteInPlace $out/bin/startatp \
      --replace-fail "startplasma-x11" "${kdePackages.plasma-workspace}/bin/startplasma-x11"

    substituteInPlace $out/bin/startatp-wayland \
      --replace-fail "$out/libexec/plasma-dbus-run-session-if-needed" "${kdePackages.plasma-workspace}/libexec/plasma-dbus-run-session-if-needed" \
      --replace-fail "$out/bin/startplasma-wayland" "${kdePackages.plasma-workspace}/bin/startplasma-wayland"
  '';

  passthru.providedSessions = [ "aerothemeplasma" "aerothemeplasmax11" ];
}