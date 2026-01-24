{
  stdenvNoCC,
  aerothemeplasma
}:
stdenvNoCC.mkDerivation {
  pname = "aerothemeplasma-layouttemplate";
  version = "2025-10-24";
  src = aerothemeplasma;

  dontUnpack = true;
  installPhase = "mkdir -p $out/share/plasma/layout-templates
  cp -r $src/plasma/layout-templates/io.gitgud.wackyideas.taskbar $out/share/plasma/layout-templates";
}