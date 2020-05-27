# frozen_string_literal: true

# application environment
require 'bundler/setup'
Bundler.require(:default)

require 'dotenv/load'

require_relative './pokemon_cli/cli.rb'
require_relative './pokemon_cli/api.rb'
require_relative './pokemon_cli/test.rb'
