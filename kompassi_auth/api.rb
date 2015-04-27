require_relative 'ipa'
require_relative 'ldap'
require_relative 'utils'

module KompassiAuth
  module API

    class << self

      def create_user(user, first_name, last_name, password)
        temporary_password = Utils.create_random_password()

        IPA.create_user(user, first_name, last_name, temporary_password)
        change_user_password(user, temporary_password, password)
      end

      def change_user_password(user, old_password, new_password)
        userdn = Utils.get_user_dn(user)

        unless LDAP.verify_user(userdn, old_password)
          puts "User authentication failed, bad username or password?"
          return false
        end

        LDAP.change_user_password(userdn, new_password)
      end

      def reset_user_password(user, new_password)
        LDAP.change_user_password(Utils.get_user_dn(user), new_password)
      end

      def ensure_group_exists(group)
        IPA.create_group(group)
      end

      def add_user_to_group(user, group)
        IPA.add_user_to_group(user, group)
      end

      def remove_user_from_group(user, group)
        IPA.remove_user_from_group(user, group)
      end

    end
  end
end
