require 'rubygems'
require 'bundler'

Bundler.require

require './forrster-rss-app'
run Sinatra::Application
