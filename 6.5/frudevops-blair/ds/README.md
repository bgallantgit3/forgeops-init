# Notes about files

The `99-user.ldif` and `subscribers.ldif` files are from the FEC Portal use case.

These two files were modified so they could be imported into the userstore DS instance.

`99-user-mods.ldif` is modified to work with the `ldapmodify` command to import the schema instead of placing it in the `db/schema` folder directly.

`subscribers-identities.ldif` was modified to use the default base DN of `ou=identities`.

In both cases, the backend of DS needs to have a suffix (base DN) added before you can import.
The `ou=identities` base DN is already in the userstore backend, so you don't need to create or add it.
You do need to add `ou=subscribers,dc=example,dc=com` to the backend before you import the original `subscribers.ldif` file.

