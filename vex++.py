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


def addCustomNodes(_self):
  """add custom qt nodes to the launcher
  Args:
    _self (qt): the main place to add nodes to
  """
  pass


import launcher

launcher.run(
  launcher.Config(
    WINDOW_TITLE="Vex++ Launcher",
    USE_HARD_LINKS=True,
    USE_CENTRAL_GAME_DATA_FOLDER=True,
    GH_USERNAME="rsa17826",
    GH_REPO="vex-plus-plus",
    getGameLogLocation=getGameLogLocation,
    gameLaunchRequested=gameLaunchRequested,
    getAssetName=getAssetName,
    gameVersionExists=gameVersionExists,
    addCustomNodes=addCustomNodes,
  )
)
