#!/bin/bash
xdg-user-dirs-update
firefox -headless -CreateProfile default
# TODO: locate the directory of the profile created above and use the
# `firefox-cert-override` python package to create `cert_override.txt` in there.
# Options:
# - manually specify the directory where the profile is created.
# - locate the `times.json` file in a directory under
