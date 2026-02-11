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

  dontUnpack = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    ln -st $out/share/fonts/truetype $src

    # https://github.com/furkrn/PlymouthVista/blob/1ad6b6592be96aa48a295733c5e44eea8a233c5b/lucon_disable_anti_aliasing.conf
    mkdir -p $out/etc/fonts/conf.d
    echo '<?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
    <fontconfig>
    <match target="font">
        <test name="family" compare="eq" qual="any"><string>Lucida Console</string></test>
        <edit name="antialias" mode="assign"><bool>false</bool></edit>
    </match>
    </fontconfig>' > $out/etc/fonts/conf.d/09-lucida-console.conf
    # do not change the priority to >= 10! 10 is used
    # by the nixos "fonts.fontconfig.antialias" option

    runHook postInstall
  '';
}