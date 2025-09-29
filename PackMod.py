from zipfile import ZipFile, ZIP_DEFLATED
import os
from os import walk
from pathlib import Path

zipName = "GAB_MOD.zip"
zipPath = "./"+zipName

locations = [
    "./anim",
    "./bigportraits",
    "./images",
    "./scripts",
    "./shaders"
]

mainFiles = [
    "./modicon.tex",
    "./modicon.xml",
    "./modinfo.lua",
    "./modmain.lua"
]

localDefFiles = []

with ZipFile(zipPath, 'w', ZIP_DEFLATED) as modZip:
    for loc in locations:
        for root, dirs, files in walk(loc):
            for file in files:
                if(file.endswith("png") or file.endswith("ps") or file.endswith("vs")):
                    print("skipping")
                else:
                    localDefFiles = os.path.join(root, file)
                    modZip.write(localDefFiles)
    for files in mainFiles:
        modZip.write(files)
    modZip.close()
