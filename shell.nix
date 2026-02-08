{
  pkgs ? import <nixpkgs> { },
}:

let
  pythonEnv = pkgs.python313.withPackages (
    ps: with ps; [
      pip
      setuptools
      wheel
    ]
  );

  # System libraries required by PySide6 and its dependencies
  libraries = with pkgs; [
    stdenv.cc.cc.lib
    zstd # Added to fix: libzstd.so.1: cannot open shared object file
    libGL
    glib
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXi
    fontconfig
    freetype
    dbus
    libxkbcommon
    wayland
  ];
in
pkgs.mkShell {
  buildInputs = [
    pythonEnv
  ]
  ++ libraries;

  shellHook = ''
    # Create/Activate Virtual Environment
    if [ ! -d ".venv" ]; then
      echo "Creating virtual environment..."
      python -m venv .venv
      pip install -e ./base
      pip install -r ./base/requirements.txt
      rm -rf ./base/launcher.egg-info
    fi
    source .venv/bin/activate

    # Fix Library Paths for Pip Binaries
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libraries}:$LD_LIBRARY_PATH"

    # Fix Qt Plugin Paths
    export QT_QPA_PLATFORM_PLUGIN_PATH="${pkgs.qt6.qtbase}/lib/qt-6/plugins"

    # Force X11 for better compatibility in Nix shells
    export QT_QPA_PLATFORM="xcb" 

    python ./base/launcher/__init__.py
  '';
}
