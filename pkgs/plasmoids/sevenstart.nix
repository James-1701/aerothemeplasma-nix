{
  stdenv,
  aerothemeplasma,
  kdePackages,
  libplasma,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-sevenstart";
  version = "2026-01-04";
  src = aerothemeplasma;

  preConfigure = ''
    cd plasma/plasmoids/src/sevenstart_src
    # ??? it works i guess ???
    substituteInPlace CMakeLists.txt --replace-fail "add_subdirectory(src)" ""
    echo -e "find_package(PlasmaQuick)\nadd_subdirectory(src)" >> CMakeLists.txt
    substituteInPlace src/CMakeLists.txt --replace-fail "Plasma" "Plasma::Plasma"
    substituteInPlace src/CMakeLists.txt --replace-fail "/usr/include/Plasma::Plasma" "Plasma"
  '';
  buildInputs = [ libplasma ];
  nativeBuildInputs = [ cmake kdePackages.wrapQtAppsHook ];
  postInstall = ''
    mkdir -p $out/share/plasma/plasmoids
    cp -r $src/plasma/plasmoids/io.gitgud.wackyideas.SevenStart $out/share/plasma/plasmoids
    substituteInPlace $out/share/plasma/plasmoids/io.gitgud.wackyideas.SevenStart/contents/ui/*.qml \
      --replace-quiet "import org.kde.plasma.core" "import io.gitgud.wackyideas.plasma.core"
  '';
}