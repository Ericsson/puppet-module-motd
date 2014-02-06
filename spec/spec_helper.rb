require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'

# SimpleCov and Coveralls require at least Ruby v1.9.3
if RUBY_VERSION >= '1.9.3'

  # Do not test other modules brought in for dependencies
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/fixtures/modules/"
  end

  require 'coveralls'
  Coveralls.wear!
end
