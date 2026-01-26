{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-authui7";
  version = "2025-10-26";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/plasma/look-and-feel
    cp -r $src/plasma/look-and-feel/authui7 $out/share/plasma/look-and-feel

    # authui7 tries to be clever by loading 'bgtexture.jpg' from a
    # hardcoded path of the installed SDDM theme, thus assuming the
    # user has the theme in /usr/share/sddm. let's just copy it over
    chmod +w $out/share/plasma/look-and-feel/authui7/contents/images
    cp $src/plasma/sddm/sddm-theme-mod/bgtexture.jpg $out/share/plasma/look-and-feel/authui7/contents/images

    substituteInPlace \
      $out/share/plasma/look-and-feel/authui7/contents/logout/Logout.qml \
      $out/share/plasma/look-and-feel/authui7/contents/splash/Splash.qml \
      --replace-fail "/usr/share/sddm/themes/sddm-theme-mod/bgtexture.jpg" "../images/bgtexture.jpg"

    # and it makes no use of QtMultimedia, so let's just remove it
    substituteInPlace \
      $out/share/plasma/look-and-feel/authui7/contents/splash/Splash.qml \
      --replace-fail "import QtMultimedia" ""

    runHook postInstall
  '';
}