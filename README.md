# Kompassi–IPA REST bridge (obsolete)

This package abstracts the IPA functions needed by Kompassi.

Note that we abandoned this line of development as it was [discovered](https://vda.li/en/posts/2015/05/28/talking-to-freeipa-api-with-sessions/) that one can access the FreeIPA JSON-RPC API via password-authenticated HTTPS without having to resort to Kerberos.

## Gettings started

    bundle install
    ruby restipad.rb
