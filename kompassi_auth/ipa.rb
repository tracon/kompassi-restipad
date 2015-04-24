require 'httpi'
require 'curb'
require 'json'

require_relative '../config/settings'

module KompassiAuth
  module IPA

    HTTPI.adapter = :curb

    class Error < RuntimeError; end
    class HTTPError < Error; end
    class IPAError < Error; end

    class << self

      def json_rpc(method_name, *args, **kwargs)
        payload = {
          "params" => [args, kwargs],
          "method" => method_name,
          "id" => 0,
        }

        request = HTTPI::Request.new
        request.url = settings.IPA_JSONRPC
        request.auth.ssl.ca_cert_file = settings.IPA_CACERT_PATH
        request.auth.ssl.ssl_version = settings.SSL_VERSION
        request.auth.gssnegotiate
        request.headers = {
          "Referer" => settings.IPA_JSONRPC,
          "Content-Type" => "application/json",
        }
        request.body = {
          "params" => [args, kwargs],
          "method" => method_name,
          "id" => 0,
        }.to_json

        begin
          response = HTTPI.post(request)
          raíse HTTPError, "HTTP Error: #{response.code}" if response.error?
        rescue StandardError => e
          puts e.message
          puts e.backtrace.inspect
          raise
        end

        begin
          result = JSON.parse(response.body)
          error = result["error"] || nil
          raise IPAError, error if error
        rescue IPAError => e
          #puts 'backstrace:', e.backtrace.inspect
          raise IPAError, e
        rescue StandardError => e
          puts 'backstrace:', e.backtrace.inspect
          raise
        end

        return result
      end

      def add_user_to_group(username, groupname)
        return json_rpc('group_add_member', groupname, user: [username])
      end

      def remove_user_from_group(username, groupname)
        return json_rpc('group_remove_member', groupname, user: [username])
      end

      def create_user(username, first_name, surname, password)
        return json_rpc('user_add', username,
          givenname: first_name,
          sn: surname,
          userpassword: password
          )
      end

      def create_group(group_name)
        begin
          return json_rpc('group_add', group_name, description: group_name)
        rescue IPAError => e
          begin
            # e.message is a string with a ruby hash syntax,
            # just evaluate to re-hashify it. :-)
            error = eval(e.message)
            code = error["code"]
          rescue KeyError, IndexError
            # Means that either we have connection error with IPA or
            # some other excrement met a propeller
            raise e
          else
            if code == 4002
              # group already exists
              # we are under "ensure exists" semantics so this is OK
              return nil
            else
              # some other error
              raise e
            end
          end
        end
      end


      # XXX Pasted from the orginal python settings,
      #     TO-D
      #     TO-DO: conversion to Ruby if needed
      #

      # def change_user_password(dn, old_password, new_password)
      #   with ldap_session() as l:
      #   l.simple_bind_s(dn, u(old_password))
      #   l.passwd_s(dn, u(old_password), u(new_password))
      # end

      # def ldap_modify(dn, *modlist)
      #   with ldap_session() as l:
      #   l.modify_s(dn, modlist)
      # end



    end
  end
end

