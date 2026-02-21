{
  kdePackages,
  libplasma,
  lib
}:
kdePackages.plasma-workspace.overrideAttrs (oldAttrs: {
  pname = "aeroshell";
  cmakeFlags = oldAttrs.cmakeFlags ++ [
    (lib.cmakeFeature "Plasma_DIR" "${libplasma.dev}/lib/cmake/Plasma")
    (lib.cmakeFeature "PlasmaQuick_DIR" "${libplasma.dev}/lib/cmake/PlasmaQuick")
  ];
  ninjaFlags = [ "plasmashell" ];
  postPatch = ''
    shopt -s globstar

    # helper to just set OUTPUT_NAME when possible
    setOutputName () {
      echo "set_target_properties($1 PROPERTIES OUTPUT_NAME $2)" >> CMakeLists.txt
    }
    # rename plasmashell and its dependencies
    setOutputName plasmashell aeroshell
    setOutputName startplasma-wayland startatplasma-wayland
    setOutputName klookandfeel atp-klookandfeel
    setOutputName kworkspace atp-kworkspace
    setOutputName krdb atp-krdb
    substituteInPlace shell/plasma-plasmashell.service.in \
      --replace-fail "BINDIR@/plasmashell" "BINDIR@/aeroshell"

    # throw out tools that main plasma-workspace can provide and rename libexec scripts
    mv startkde/plasma-dbus-run-session-if-needed startkde/atplasma-dbus-run-session-if-needed
    mv startkde/plasma-sourceenv.sh startkde/atplasma-sourceenv.sh
    substituteInPlace startkde/CMakeLists.txt \
      --replace-fail "add_subdirectory(" '#add_subdirectory(' \
      --replace-fail "#add_subdirectory(systemd)" 'add_subdirectory(systemd)' \
      --replace-fail "install(PROGRAMS plasma-dbus-run-session-if-needed" "install(PROGRAMS atplasma-dbus-run-session-if-needed" \
      --replace-fail "install(PROGRAMS plasma-sourceenv.sh" "install(PROGRAMS atplasma-sourceenv.sh"
    substituteInPlace startkde/startplasma.cpp \
      --replace-fail "plasma-sourceenv.sh" "atplasma-sourceenv.sh"

    # more stuff providable by main plasma-workspace
    sed -i "/kde-systemd-start-condition/d" startkde/systemd/CMakeLists.txt
    sed -i "/kconf_update/d" shell/CMakeLists.txt
    sed -i "/DBUSINTERFACE/d" shell/CMakeLists.txt

    # rename targets and all references to them
    mv startkde/systemd/plasma-core.target startkde/systemd/atplasma-core.target
    mv startkde/systemd/plasma-workspace.target startkde/systemd/atplasma-workspace.target
    mv startkde/systemd/plasma-workspace-wayland.target startkde/systemd/atplasma-workspace-wayland.target
    substituteInPlace startkde/systemd/CMakeLists.txt \
      --replace-fail "plasma-core.target" "atplasma-core.target" \
      --replace-fail "plasma-workspace.target" "atplasma-workspace.target" \
      --replace-fail "plasma-workspace-wayland.target" "atplasma-workspace-wayland.target"
    substituteInPlace startkde/startplasma.cpp \
      --replace-fail "plasma-workspace-%1.target" "atplasma-workspace-%1.target"
    substituteInPlace startkde/systemd/atplasma-workspace-wayland.target \
      --replace-fail "plasma-workspace.target" "atplasma-workspace.target"
    substituteInPlace startkde/systemd/atplasma-workspace.target \
      --replace-fail "plasma-core.target" "atplasma-core.target"

    # rename plasmashell service and all references to it
    mv shell/plasma-plasmashell.service.in shell/atplasma-aeroshell.service.in
    substituteInPlace shell/CMakeLists.txt startkde/systemd/atplasma-core.target \
      --replace-fail "plasma-plasmashell.service" "atplasma-aeroshell.service"

    # rename desktop file and fix its plasmashell reference
    mv shell/org.kde.plasmashell.desktop.cmake shell/io.gitgud.wackyideas.aeroshell.desktop.cmake
    substituteInPlace shell/CMakeLists.txt \
      --replace-fail "org.kde.plasmashell.desktop" "io.gitgud.wackyideas.aeroshell.desktop"
    substituteInPlace shell/io.gitgud.wackyideas.aeroshell.desktop.cmake \
      --replace-fail "PREFIX@/bin/plasmashell" "PREFIX@/bin/aeroshell"

    # systemd doesn't like that two services occupy the same bus name even
    # if they'll never run at the same time, so we have to use type=simple
    substituteInPlace shell/atplasma-aeroshell.service.in \
      --replace-fail "Type=dbus" "Type=simple" \
      --replace-fail "BusName=org.kde.plasmashell" ""
  '';
  installPhase = ''
    runHook preInstall
    ninja shell/install startkde/install libklookandfeel/install kcms/krdb/install libkworkspace/install
    rm -rf $out/lib/qt-6 $out/bin/startplasma-x11 $out/share/systemd/user/plasma-workspace-x11.target
    runHook postInstall
  '';
  # nixpkgs: "Prevent patching this shell file, as it is only used by sourcing it from /bin/sh."
  postInstall = "chmod -x $out/libexec/atplasma-sourceenv.sh";
})