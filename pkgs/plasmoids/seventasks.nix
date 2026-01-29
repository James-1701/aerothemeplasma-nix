{
  stdenv,
  aerothemeplasma,
  kdePackages,
  libplasma,
  cmake
}:
stdenv.mkDerivation {
  pname = "aerothemeplasma-seventasks";
  version = "2025-07-25";
  src = aerothemeplasma;

  preConfigure = "cd plasma/plasmoids/src/seventasks_src";
  buildInputs = [ libplasma ];
  nativeBuildInputs = [ cmake ] ++ (with kdePackages; [ kpackage wrapQtAppsHook ]);
  postInstall = ''
    mkdir -p $out/share/plasma/plasmoids
    cp -r $src/plasma/plasmoids/io.gitgud.wackyideas.seventasks $out/share/plasma/plasmoids
    substituteInPlace $out/share/plasma/plasmoids/io.gitgud.wackyideas.seventasks/contents/*/*.qml \
      --replace-quiet "import org.kde.plasma.core" "import io.gitgud.wackyideas.plasma.core"
  '';
}