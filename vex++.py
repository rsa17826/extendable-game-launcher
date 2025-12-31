import os
import subprocess


def getGameLogLocation():
  return ""


def gameLaunchRequested(path):
  """called when the user tries to launch a version of the game
  this should open the game when called
  Args:
    path (str): the path to the game dir
  """
  exe = os.path.join(path, "vex.exe")
  if os.path.isfile(exe):
    subprocess.Popen([exe], cwd=path)


def getAssetName():
  """file to download from gh releases eg windows.zip
  Returns:
    str
  """
  return "windows.zip"


def gameVersionExists(path):
  """return true if the dir has a valid game version in it
  Args:
    path (str): path to dir to check
  Returns:
    bool: true if the given dir has a valid game in it
  """
  return os.path.isfile(os.path.join(path, "vex.pck"))

from PySide6.QtWidgets import QWidget

def addCustomNodes(_self, layout) -> dict[str, QWidget]:
  """
  Args:
    _self: The Launcher instance (to register widgets for saving)
    layout: The QVBoxLayout of the Local Settings section
  """

  level_name_input = _self.newLineEdit('Enter level name (e.g. Level_01)', 'input_level_name')
  layout.addWidget(_self.newCheckbox("Load Specific Level on Start", False, 'cb_load_custom_level', onChange=level_name_input.setEnabled))
  level_name_input.setEnabled(_self.settings.cb_load_custom_level)
  layout.addWidget(level_name_input)

  return {}


import launcher

launcher.run(
  launcher.Config(
    WINDOW_TITLE="Vex++ Launcher",
    USE_HARD_LINKS=True,
    CAN_USE_CENTRAL_GAME_DATA_FOLDER=True,
    GH_USERNAME="rsa17826",
    GH_REPO="vex-plus-plus",
    getGameLogLocation=getGameLogLocation,
    gameLaunchRequested=gameLaunchRequested,
    getAssetName=getAssetName,
    gameVersionExists=gameVersionExists,
    addCustomNodes=addCustomNodes,
  )
)
