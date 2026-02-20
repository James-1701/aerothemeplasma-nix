{
  kdePackages,
  aerothemeplasma
}:
kdePackages.libplasma.overrideAttrs (oldAttrs: {
  pname = "aerothemeplasma-libplasma";
  postPatch = ''
    shopt -s globstar
    cp -r ${aerothemeplasma}/misc/libplasma/src .

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