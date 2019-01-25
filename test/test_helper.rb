$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'ocawari'

require 'minitest/autorun'
require "minitest/reporters"
require "vcr"
require 'webmock/minitest'
require "pry"
require "uri"
require "mini_magick"

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new({color: true})]

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr"
  config.hook_into :webmock
end
