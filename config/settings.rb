require 'configatron'

#'With this hack, files that require this file, will have access
# to configatron store by using: settings.<key>
def settings()
  configatron
end

# Put your configuration key = value pairs here,
# prefix them with 'configatron.', for example: configatron.foo = 'bar'
configatron.LDAP_DOMAIN = 'dc=tracon,dc=fi'
configatron.LDAP_USERS = "cn=users,cn=accounts,#{configatron.LDAP_DOMAIN}"
configatron.LDAP_GROUPS = "cn=groups,cn=accounts,#{configatron.LDAP_DOMAIN}"

configatron.IPA_JSONRPC = 'https://moukari.tracon.fi/ipa/json'

#configatron.IPA_CACERT_PATH = '/etc/ipa/ca.crt'
configatron.IPA_CACERT_PATH = "#{ENV['HOME']}/.ipa/ca.crt"
configatron.SSL_VERSION = :TLSv1

configatron.LDAP_SERVER_URI = 'ldaps://localhost:62636'
#configatron.LDAP_SERVER_URI = 'ldaps://moukari.tracon.fi'


# XXX Pasted from the orginal python settings, still unsure if needed
#
# configatron.LDAP_BIND_DN = ''
# configatron.LDAP_BIND_PASSWORD = ''
# configatron.LDAP_USER_DN_TEMPLATE = 'uid=#{user},#{configatron.LDAP_USERS}'
# configatron.LDAP_USER_SEARCH = LDAPSearch(
#     KOMPASSI_LDAP_USERS,
#     ldap.SCOPE_SUBTREE,
#     '(uid=%(user)s)'
# )
# configatron.LDAP_ALWAYS_UPDATE_USER = True
# configatron.LDAP_GROUP_SEARCH = LDAPSearch(
#     KOMPASSI_LDAP_GROUPS,
#     ldap.SCOPE_SUBTREE,
#     '(objectClass=groupOfNames)'
# )
# configatron.LDAP_GROUP_TYPE = NestedGroupOfNamesType()
# configatron.LDAP_MIRROR_GROUPS = True
