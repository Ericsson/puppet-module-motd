require 'spec_helper'
describe 'motd' do

  it { should compile.with_all_deps }

  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }

    it { should contain_class('motd') }

    it {
      should contain_file('motd').with({
        'ensure' => 'file',
        'path'   => '/etc/motd',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    }

    it {
      should contain_file('issue').with({
        'ensure' => 'file',
        'path'   => '/etc/issue',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    }

    it {
      should contain_file('issue.net').with({
        'ensure' => 'file',
        'path'   => '/etc/issue.net',
        'owner'  => 'root',
        'group'  => 'root',
        'mode'   => '0644',
      })
    }
  end

  context 'with content related parameters set' do
  end

  describe 'with invalid path' do
    context 'specified for motd' do
      let(:params) { { :motd_file => 'invalid/path' } }

      it 'should fail' do
        expect {
          should contain_class('motd')
        }.to raise_error(Puppet::Error)
      end
    end

    context 'specified for issue' do
      let(:params) { { :issue_file => 'invalid/path' } }

      it 'should fail' do
        expect {
          should contain_class('motd')
        }.to raise_error(Puppet::Error)
      end
    end

    context 'specified for issue.net' do
      let(:params) { { :issue_net_file => 'invalid/path' } }

      it 'should fail' do
        expect {
          should contain_class('motd')
        }.to raise_error(Puppet::Error)
      end
    end
  end

  ensure_hash = {
    'motd_ensure' => {
      :name => 'motd',
      :path => '/etc/motd',
    },
    'issue_ensure' => {
      :name => 'issue',
      :path => '/etc/issue',
    },
    'issue_net_ensure' => {
      :name => 'issue.net',
      :path => '/etc/issue.net',
    },
  }

  ensure_hash.sort.each do |k,v|
    describe "with parameter #{k}" do
      ['file','present','absent'].each do |value|
        context "set to the valid value of #{value}" do
          let(:params) { { :"#{k}" => value } }

          it { should compile.with_all_deps }

          it { should contain_class('motd') }

          it {
            should contain_file(v[:name]).with({
              'ensure' => value,
              'path'   => v[:path],
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0644',
            })
          }
        end
      end

      ['directory','link',true,false].each do |value|
        context "set to the invalid value of #{value}" do
          let(:params) { { :"#{k}" => value } }

          it 'should fail' do
            expect {
              should contain_class('motd')
            }.to raise_error(Puppet::Error)
          end
        end
      end
    end
  end

  context 'with invalid value for issue_ensure' do
  end

  context 'with invalid value for issue_net_ensure' do
  end

  context 'with invalid value for motd_mode' do
  end

  context 'with invalid value for issue_mode' do
  end

  context 'with invalid value for issue_net_mode' do
  end

end
