require 'rubygems'
require 'bundler'

Bundler.require

require 'json'
require 'net/http'
require 'active_support/core_ext/object'
require 'active_support/core_ext/hash/indifferent_access.rb'

require './forrster-feed-app'
run Sinatra::Application
