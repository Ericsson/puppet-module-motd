require 'spec_helper'
describe 'motd' do

  it { should compile.with_all_deps }

  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }

    it { should contain_class('motd') }

    it {
      should contain_file('motd').with({
        'ensure'  => 'file',
        'path'    => '/etc/motd',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'content' => nil,
      })
    }

    it {
      should contain_file('issue').with({
        'ensure'  => 'file',
        'path'    => '/etc/issue',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'content' => nil,
      })
    }

    it {
      should contain_file('issue_net').with({
        'ensure'  => 'file',
        'path'    => '/etc/issue.net',
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0644',
        'content' => nil,
      })
    }
  end

  describe 'with invalid path' do
    ['motd','issue','issue_net'].each do |resource|
      context "specified for #{resource}_file" do
        let(:params) { { :"#{resource}_file" => 'invalid/path' } }

        it 'should fail' do
          expect {
            should contain_class('motd')
          }.to raise_error(Puppet::Error)
        end
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
      :name => 'issue_net',
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

  ['motd','issue','issue_net'].each do |resource|
    describe "#{resource} specified" do
      context 'with content specified' do
        let(:params) { { :"#{resource}_content" => 'foobar' } }

        it {
          should contain_file(resource).with({
            'ensure' => 'file',
            'owner'  => 'root',
            'group'  => 'root',
            'mode'   => '0644',
            'content' => /^foobar$/,
          })
        }
      end

      ['0775','0664'].each do |mode|
        context "with mode set to valid value of #{mode}" do
          let(:params) { { :"#{resource}_mode" => mode } }

          it {
            should contain_file(resource).with({
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => mode,
            })
          }
        end
      end

      [true,'664','66666','invalid'].each do |mode|
        context "with mode set to invalid value of #{mode}" do
          let(:params) { { :"#{resource}_mode" => mode } }

          it 'should fail' do
            expect {
              should contain_class('motd')
            }.to raise_error(Puppet::Error,/vim::#{resource}_mode does not match regex. Must be a four digit string./)
          end
        end
      end
    end
  end
end
