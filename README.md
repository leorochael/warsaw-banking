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

 - Use [`equivs`](https://eric.lubow.org/2010/creating-dummy-packages-on-debian/) to create a fake
   zenity package to save on all its dependencies.
   - This will probably require a separate build container, as `equivs` and deps require 200+MB
 - Uninstall unnecessary packages (e.g. sshd) during `root/install.sh`
 - Automate appending the generated `cert_override.txt` for use by firefox outside the container
 - Create `.desktop` launcher
