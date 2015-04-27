require 'net/ldap'
require 'date'

require_relative '../config/settings'
require_relative 'utils'

module KompassiAuth
  module LDAP

    class << self

      def ldap()
        begin
          client = Net::LDAP.new(
            host: settings.LDAP_SERVER,
            port: settings.LDAP_SERVER_PORT,
            base: settings.LDAP_DOMAIN,
            encryption: settings.LDAP_ENCRYPTION_METHOD,
            auth: { method: settings.LDAP_AUTH_METHOD, }
          )
        rescue StandardError => e
          puts e.message
          puts 'backstrace:', e.backtrace.inspect
          raise
        else
          yield client
        ensure
          client = nil
        end
      end
      private :ldap

      def ldap_modify(dn, modlist)
        ldap do |client|
          begin
            client.auth(settings.LDAP_BIND_DN, settings.LDAP_BIND_PASSWORD)
            return client.modify(dn: dn, operations: modlist)
          rescue StandardError => e
            puts e.message
            puts client.get_operation_result
            puts 'backstrace:', e.backtrace.inspect
            raise
          end
        end
      end
      private :ldap_modify

      def verify_user(userdn, password)
        ldap do |client|
          client.auth(userdn, password)
          return client.bind
        end
      end

      def change_user_password(userdn, new_password)
        date_in_future = DateTime.now + 2000  # days
        new_krb_pw_expiration_date = date_in_future.strftime('%Y%m%d%H%M%SZ')
        ldap_modlist = [
          [ :replace, :userPassword, Utils.u(new_password) ],
          [ :replace, :krbPasswordExpiration, new_krb_pw_expiration_date ],
        ]
        return ldap_modify(userdn, ldap_modlist)
      end

    end
  end
end
