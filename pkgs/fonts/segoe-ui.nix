{
  stdenvNoCC,
  requireFile
}:
let
  requireFont = name: hash: requireFile {
    inherit name hash;
    message = ''
      Please grab C:\Windows\Fonts\${name} from an up-to-date install of Windows 7.
      You will likely need to grab more. See https://github.com/nyakase/aerothemeplasma-nix.
      Once you have the file, run "nix store add-file ${name}", then try again.'';
  };
in
stdenvNoCC.mkDerivation {
  pname = "segoe-ui";
  version = "5.13";

  srcs = [
    (requireFont "segoeui.ttf" "sha256-D3hVlE5czKjkDOkKzkBiYkhTq2SE3bZfRDfM9w/tQq0=")
    (requireFont "segoeuib.ttf" "sha256-3phVBDDi4XqDmdsJTxqAl0OhN8y6OJsPC1YGFHPSmtQ=")
    (requireFont "seguisb.ttf" "sha256-e2H8pj2ibkVERAL0LOBospJE2dPTUehnlt98oKlN9jw=")
    (requireFont "segoeuii.ttf" "sha256-LwAe+oiW8eOK/rpZ7i/6H3clt4qbJ5wftRqI0mj2URA=")
  ];

  dontUnpack = true;
  installPhase = "mkdir -p $out/share/fonts/truetype
  ln -st $out/share/fonts/truetype $srcs";
}