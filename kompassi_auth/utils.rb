require_relative '../config/settings'

module KompassiAuth
  module Utils

    class << self

      def create_random_password(password_length = 64)
        password_length = password_length - 1
        character_map = [('a'...'z'), ('A'...'Z'), (0..9)].map { |i| i.to_a }.
          flatten
        return (0..password_length).
          map { character_map[rand(character_map.length)] }.join
      end

      def get_user_dn(uid)
        return 'uid=%{uid},%{branch}' % { uid: uid,
                                          branch: settings.LDAP_USERS }
      end

      def u(unicode_string)
        return unicode_string.encode('utf-8')
      end

    end
  end
end

