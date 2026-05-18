{
  kdePackages,
  fetchpatch
}:
kdePackages.libplasma.overrideAttrs (oldAttrs: {
  pname = "aeroshell-libplasma";
  patches = [
   ../../../patches/aeroshell-libplasma-3b0709a2.patch
   ../../../patches/aeroshell-libplasma-a4e0bcc9.patch
  ];
  postPatch = ''
    shopt -s globstar

    substituteInPlace src/**/CMakeLists.txt \
      --replace-warn 'URI "org.kde.plasma.' 'URI "io.gitgud.wackyideas.plasma.' \
      --replace-warn "EXPORT_NAME Plasma" "OUTPUT_NAME ATPlasma"
    substituteInPlace src/**/*.qml --replace-quiet "import org.kde.plasma." "import io.gitgud.wackyideas.plasma."

    substituteInPlace src/declarativeimports/core/tooltipdialog.cpp --replace-fail \
      'SourceFromModule("org.kde.plasma.' 'SourceFromModule("io.gitgud.wackyideas.plasma.'

    substituteInPlace src/declarativeimports/CMakeLists.txt --replace-fail "add_subdirectory(kirigamiplasmastyle)" ""
    substituteInPlace src/plasma/CMakeLists.txt --replace-fail "add_subdirectory(packagestructure)" ""
  '';
  ninjaFlags = ["corebindingsplugin"];
  postFixup = "rm -rf $out/share";
})
