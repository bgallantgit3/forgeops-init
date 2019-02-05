# Notes about using `frconfig` and `secrets`

* The `id_rsa` and `id_rsa.pub` private and public keys here are for `frconfig` specifically.

* The public key is uploaded to GitHub as a "Deploy" key with read/write access to the `forgeops-init` repository.
    This is done by going to GitHub settings and using the browser to upload.
    Be sure to make it writable.

* The private key is in this folder and used by the `frconfig` Helm chart during installation to deploy to the given namespace.
    Note that the private key should not be uploaded to GitHub and should be protected.

* This private key (secret) allows the cluster to access and write configuration changes to the `forgeops-init` repository, when invoked through the `git-sync.sh` exec.

* **THE PRIVATE KEY should never be uploaded to GitHub for others to see and misuse.**

* You should delete the deploy key from GitHub and regenerate the keys again if you suspect the private key is compromised.
