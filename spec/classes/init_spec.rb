require 'spec_helper'
describe 'motd' do

  it { should compile.with_all_deps }

  context 'with default options' do
    it { should contain_class('motd') }
  end
end
