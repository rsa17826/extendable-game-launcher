{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    python3
    python3Packages.pyside6
    python3Packages.requests
    python3Packages.py7zr
    
    # System dependencies for Qt6
    qt6.qtbase
    qt6.qtwayland
    libGL
    xorg.libX11
    xorg.libXcursor
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrender
    xorg.libXtst
    libxkbcommon
    fontconfig
    freetype
  ];
}