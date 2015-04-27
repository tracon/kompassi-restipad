require 'configatron'

#'With this hack, files that require this file, will have access
# to configatron store by using: settings.<key>
def settings()
  configatron
end

# Put your configuration key = value pairs here,
# prefix them with 'configatron.', for example: configatron.foo = 'bar'

configatron.IPA_JSONRPC = 'https://moukari.tracon.fi/ipa/json'
#configatron.IPA_CACERT_PATH = '/etc/ipa/ca.crt'
configatron.IPA_CACERT_PATH = "#{ENV['HOME']}/.ipa/ca.crt"
configatron.IPA_SSL_VERSION = :TLSv1

configatron.LDAP_DOMAIN = 'dc=tracon,dc=fi'
configatron.LDAP_USERS = "cn=users,cn=accounts,#{configatron.LDAP_DOMAIN}"
configatron.LDAP_GROUPS = "cn=groups,cn=accounts,#{configatron.LDAP_DOMAIN}"

configatron.LDAP_SERVER_URI = 'ldaps://localhost:62636'
#configatron.LDAP_SERVER_URI = 'ldaps://moukari.tracon.fi'
configatron.LDAP_SERVER = 'localhost'
configatron.LDAP_SERVER_PORT = 62636

configatron.LDAP_ENCRYPTION_METHOD = :simple_tls
configatron.LDAP_AUTH_METHOD = :simple
configatron.LDAP_BIND_DN = 'cn=Directory Manager'
configatron.LDAP_BIND_PASSWORD = File.open( "#{ENV['HOME']}/.ipa/dmpass",
                                            &:readline).strip
