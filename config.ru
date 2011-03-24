require 'rubygems'
require 'bundler'

Bundler.require

require './forrster-feed-app'
run Sinatra::Application
