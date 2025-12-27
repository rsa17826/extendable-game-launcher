{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    python3Packages.pyside6
    python3Packages.requests
    python3Packages.py7zr
    # Qt6 dependencies for NixOS
    qt6.qtbase
    qt6.qtwayland # required if you use Wayland
    libGL
    xorg.libX11
  ];

  shellHook = ''
    # Fix for Qt/PySide6 on NixOS
    export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt6.qtbase.bin}/lib/qt-6/plugins"
    export LD_LIBRARY_PATH="${pkgs.libGL}/lib:${pkgs.xorg.libX11}/lib:$LD_LIBRARY_PATH"
    echo "Launcher dev environment loaded!"
  '';
}