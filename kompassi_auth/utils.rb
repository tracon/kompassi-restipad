require_relative '../config/settings'
require_relative 'ipa'

module KompassiAuth
  module Utils

    class << self

      def generate_random_password(password_length = 64)
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

      # XXX Pasted from the orginal python settings,
      #     TO-DO: conversion to Ruby
      #
      # def create_user(user, password):
      #   temporary_password = create_temporary_password()

      #   ipa.create_user(
      #     username=user.username,
      #     first_name=user.first_name,
      #     surname=user.last_name,
      #     password=temporary_password,
      #     )

      #   for group_name in settings.KOMPASSI_NEW_USER_INITIAL_GROUPS:
      #     ipa.add_user_to_group(user.username, group_name)
      #   end

      #   ipa.change_user_password(
      #     dn=get_user_dn(user.username),
      #     old_password=temporary_password,
      #     new_password=password,
      #     )
      # end


      # def change_current_user_password(request, old_password, new_password):
      #   ipa.change_user_password(
      #     dn=request.user.ldap_user.dn,
      #     old_password=old_password,
      #     new_password=new_password
      #     )
      # end


      # def add_user_to_group(user, group):
      #   ipa.add_user_to_group(user.username, group.name)
      # end

      # def remove_user_from_group(user, group):
      #   ipa.remove_user_from_group(user.username, group.name)
      # end

      # def reset_user_password(user, new_password):
      #   temporary_password = create_temporary_password()

      #   ipa.admin_set_user_password(user.username, temporary_password)
      #   ipa.change_user_password(
      #     dn=get_user_dn(user.username),
      #     old_password=temporary_password,
      #     new_password=new_password
      #     )
      # end

      # def ensure_group_exists(group):
      #   if type(group) not in [str, unicode]:
      #     group = group.name
      #   end

      #   ipa.create_group(group)
      # end

    end
  end
end

