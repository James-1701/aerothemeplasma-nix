{
  stdenvNoCC,
  requireFile
}:
stdenvNoCC.mkDerivation {
  pname = "lucida-console";
  version = "5";

  src = requireFile rec {
    name = "lucon.ttf";
    hash = "sha256-9N9NbRpp0k4I2irS9FIDtMcUfdqlGHzNcwh5A8o20Xc=";
    message = ''
      Please grab C:\Windows\Fonts\${name} from an up-to-date install of Windows 7.
      You will likely need to grab more. See https://github.com/nyakase/aerothemeplasma-nix.
      Once you have the file, run "nix store add-file ${name}", then try again.'';
  };

  phases = [ "installPhase" ];
  installPhase = "mkdir -p $out/share/fonts/truetype && ln -st $out/share/fonts/truetype $src";
}