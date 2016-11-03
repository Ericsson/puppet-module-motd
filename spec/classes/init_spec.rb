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
    end
  end

  describe 'variable type and content validations' do
    # set needed custom facts and variables
    let(:facts) { {} }
    let(:mandatory_params) { {} }

    validations = {
      'regex_file_mode' => {
        :name    => %w(motd_mode issue_mode issue_net_mode),
        :valid   => %w(0755 0644 1755 0242),
        :invalid => ['string', '755', 980, '0980',%w(array), { 'ha' => 'sh' }, 3, 2.42, true, false, nil],
        :message => 'must be a valid four digit mode in octal notation',
      },
    }

    validations.sort.each do |type, var|
      var[:name].each do |var_name|
        var[:params] = {} if var[:params].nil?
        var[:valid].each do |valid|
          context "when #{var_name} (#{type}) is set to valid #{valid} (as #{valid.class})" do
            let(:params) { [mandatory_params, var[:params], { :"#{var_name}" => valid, }].reduce(:merge) }
            it { should compile }
          end
        end

        var[:invalid].each do |invalid|
          context "when #{var_name} (#{type}) is set to invalid #{invalid} (as #{invalid.class})" do
            let(:params) { [mandatory_params, var[:params], { :"#{var_name}" => invalid, }].reduce(:merge) }
            it 'should fail' do
              expect { should contain_class(subject) }.to raise_error(Puppet::Error, /#{var[:message]}/)
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'variable type and content validations'
end
