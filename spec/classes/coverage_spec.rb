if RUBY_VERSION >= '1.9.3'
  at_exit { RSpec::Puppet::Coverage.report! }
end
