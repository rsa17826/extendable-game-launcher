# { pkgs ? import <nixpkgs> {} }:

# pkgs.mkShell {
#   buildInputs = with pkgs; [
#     python3
#     python3Packages.pyside6
#     python3Packages.requests
#     python3Packages.py7zr
    
#     # System dependencies for Qt6
#     qt6.qtbase
#     qt6.qtwayland
#     libGL
#     xorg.libX11
#     xorg.libXcursor
#     xorg.libXcomposite
#     xorg.libXdamage
#     xorg.libXext
#     xorg.libXfixes
#     xorg.libXi
#     xorg.libXrender
#     xorg.libXtst
#     libxkbcommon
#     fontconfig
#     freetype
#   ];
# }
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell rec {
  buildInputs = [
    pkgs.python313Full
    pkgs.python313Packages.virtualenv
    pkgs.python313Packages.pip
    pkgs.python313Packages.setuptools
    pkgs.python313Packages.wheel
  ];

  shellHook = ''
    #!/bin/bash

    # Check if the virtual environment directory exists
    if [ -d "./.venv" ]; then
      # Activate the virtual environment
      source ./.venv/bin/activate
    else
      # Create a virtual environment using Python 3.13 (ensure python3.13 is installed)
      python3.13 -m venv .venv
      # Activate the virtual environment
      source ./.venv/bin/activate
      # Install the base package in editable mode and requirements
      pip install -e ./base
      pip install -r ./base/requirements.txt
      # Remove egg-info directory
      rm -rf ./base/launcher.egg-info
      # Run the Python script with any passed arguments
    fi
    python ./base/launcher/__init__.py "$@"
  '';
}
