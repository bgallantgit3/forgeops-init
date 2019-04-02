# Notes about files added for FR-523 revision A

The `99-user.ldif` and `subscribers.ldif` files are from the FEC Portal use case.

These two files were modified so they could be imported into the userstore DS instance depending on whether you want to use `ou=identities` or `ou=subscribers,dc=example,dc=com` base DNs or both.

* `99-user-mods.ldif` is modified to work with the `ldapmodify` command to import the schema instead of placing it in the `db/schema` folder directly.

* `subscribers-identities.ldif` was modified to use the default base DN of `ou=identities`.

In both cases, the backend of DS needs to have a suffix (base DN) added before you can import.
The `ou=identities` base DN is already in the userstore backend, so you don't need to create or add it.
You do need to add `ou=subscribers,dc=example,dc=com` to the backend before you import the original `subscribers.ldif` file.

Also, you need to use `kubectl exec userstore-0 -it bash` to get to the pod, or `kubectl port-forward userstore-0 11389:1389` to use forwarding.

Note that port 1389 might already be in use on the CloudShare VM if the local DS instance is running.

## Manually installing the schema and loading sample data using the default backend

To load the schema:
    
    `ldapmodify -h localhost -p 1389 -D "cn=Directory Manager" -w password -a -c -f 99-user-mods.ldif`

To validate the schema was updated:

    `ldapsearch -h localhost -p 1389 -D "cn=Directory Manager" -w password -b "cn=schema" -s base objectclass=subschema +  | grep fec-subscriber`

To load sample data, using ou=identities default:

    `ldapmodify -h localhost -p 1389 -D "cn=Directory Manager" -w password -a -c -f subscribers-identities.ldif`

To validate:

    `ldapsearch -h localhost -p 1389 -D "cn=Directory Manager" -w password -b "ou=identities" objectclass=groupOfUniqueNames`

    `ldapsearch -h localhost -p 1389 -D "cn=Directory Manager" -w password -b "ou=identities" objectclass=inetOrgPerson`

## Using `ou=subscribers,dc=example,dc=com` as the base DN on top of the same backend

Use `kubectl exec userstore-0 -it bash` to log into the userstore instance.

Run the `dsconfig` command to add the base DN to one of the backends:


```
$ dsconfig set-backend-prop \
    --backend-name amIdentityStore \
    --add base-dn:ou=subscribers,dc=example,dc=com \
    --hostname userstore-0 \
    --port 4444 \
    --bindDn cn=Directory\ Manager \
    --bindPassword password \
    --trustAll \
    --no-prompt
```

* The `amIdentityStore` backend was chosen because it is shared with IDM and should contain subscribers.

Return from the exec shell and load the sample entries to `ou=subscribers,dc=example.com`:

    `ldapmodify -h localhost -p 1389 -D "cn=Directory Manager" -w password -a -c -f subscribers.ldif`

To validate:

    `ldapsearch -h localhost -p 1389 -D "cn=Directory Manager" -w password -b "ou=subscribers,dc=example,dc=com" uid=*`

