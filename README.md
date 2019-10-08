Attempt to automate the build of an OCI container for running `warsaw`
===

`warsaw` is a spyware that is foisted by Brazillian banks upon Brazillian users of internet banking
under the guise of a "security module".

Installation
===

Run:

    buildah unshare -- ./build.sh

This will create a container named `warsaw-container` and a file named `cert_override.txt` under
the folder `root/artifacts`.

Locate your firefox profile folder with the command:

    cat ~/.mozilla/firefox/profiles.ini

Your profile will be the one with the key `Default=1`. The profile path will be in the `Path=` key.

Authorize your firefox profile to access the site with the command:

    cat root/artifacts/cert_override.txt >> ~/.mozilla/firefox/<PROFILE PATH>/cert_override.txt

Restart firefox if it was already running (e.g. go to `about:profiles` and click the button `Restart normally...`).

And finally, run the container with:

    podman run --rm -ti --net=host warsaw-banking

TODO:
===

 - Automate creating the profile and appending the generated `cert_override.txt` in the container inside firefox during build
 - Automate `xauth add` or some other form of using .Xauthority from outside the container.
 - Find a way to mount or export the `Downloads` folder from the container so it's easier to export PDF receipts and stuff
    - This means finding a way of making the internal `ubuntu` user run as the same uid as the user running podman.
    - A less satisfying alternative is to mount an external directory, chown to the ubuntu user at boot and chown to root at
      container shutdown.
    - Even less satisfying, but better than nothing, is to create a subdirectory on `/tmp`.
 - Create `.desktop` launcher and app indicator that shows warsaw is running, like pgadmin4
 - Uninstall unnecessary packages (e.g. sshd) during `root/install.sh`
 - Use [`equivs`](https://eric.lubow.org/2010/creating-dummy-packages-on-debian/) to create a fake
   zenity package to save on all its dependencies.
   - This will probably require a separate build container, as `equivs` and deps require 200+MB
