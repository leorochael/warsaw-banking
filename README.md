Attempt to automate the build of an OCI container for installing `warsaw`

`warsaw` is a spyware that is foisted upon Brazillian users of internet banking by Brazillian banks
under the guise of a "security module".

===

TODO:

 - Start the `ubuntu` user warsaw (core) automatically
   - Check/debug if calling `/usr/bin/warsaw` is enough
 - Debug tab crash in firefox inside the container
 - Uninstall unnecessary packages (e.g. sshd) during `root/install.sh`
 - Automate the generation of the `cert_override.txt` file inside the firefox profile
 - Automate the generation of `cert_override.txt` for use by firefox outside the container
 - Create launchers and other conveniences