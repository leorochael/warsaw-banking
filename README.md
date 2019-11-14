Attempt to automate the build of an OCI container for running `warsaw`
===

`warsaw` is a spyware that is foisted by Brazillian banks upon Brazillian users of internet banking
under the guise of a "security module".

Installation
===

Run:

    buildah unshare -- ./build.sh

Usage:
===

Run the container with:

    ./run.sh

Once you get to the container shell, run firefox with:

    firefox --no-remote &

Saved files will be downloaded in the `~/Downloads` folder. Move them to `/tmp` to share them with the host machine.

TODO:
===

 - Installation currently adds the locally generated Warsaw Certificate Authority to the firefox profile of the `ubuntu` user.
    - Find a way to avoid that, as it's dangerous.
    - Instead, automate creating the profile and appending the generated `cert_override.txt` in the `ubuntu` user's firefox
      profile during build.
 - Find a way to mount or export the `Downloads` folder from the container so it's easier to export PDF receipts and stuff
    - This means finding a way of making the internal `ubuntu` user run as the same uid as the user running podman.
    - A less satisfying alternative is to mount an external directory, chown to the ubuntu user at boot and chown to root at
      container shutdown.
    - Or perhaps, make the host user share a group with the container, so no `chown`ing is necessary.
    - Even less satisfying, but better than nothing, is to create a subdirectory on `/tmp` from which the host use can copy files
      to their own folder.
 - Create `.desktop` launcher and app indicator that shows warsaw is running, like pgadmin4
 - Uninstall unnecessary packages (e.g. sshd, cron) during `root/install.sh`
