require "awit/version"
require "typhoeus"
require "active_support/core_ext/module/attribute_accessors"

module Awit

  mattr_accessor :auth_token
  mattr_writer :content_type
  mattr_writer :accept

  def self.content_type
    @@content_type || "application/json"
  end

  def self.accept
    @@accept || "application/json"
  end

  def self.configure
    yield self
  end

  def self.verb(verb_name, *args)
    new_args = args
    new_args[1] ||= {}
    headers = new_args[1][:headers] ||= {}
    headers[:Accept] = self.accept
    headers["content-type"] = self.content_type
    headers[:AUTHORIZATION] = "Bearer #{self.auth_token.call}"
    new_args[1][:headers] = headers
    Typhoeus.send(verb_name, *new_args)
  end

  def self.get(*args)
    verb :get, *args
  end

  def self.delete(*args)
    verb :delete, *args
  end

  def self.post(*args)
    verb :post, *args
  end

  def self.put(*args)
    verb :put, *args
  end

  def self.patch(*args)
    verb :patch, *args
  end

end
