require 'rubygems'
require 'puppetlabs_spec_helper/module_spec_helper'

begin
  require 'simplecov'
  require 'coveralls'
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
  SimpleCov.start do
    add_filter '/spec/'
    add_filter '/ext/'
  end
  Coveralls.wear!
rescue Exception => e
  warn 'Coveralls disabled'
end
