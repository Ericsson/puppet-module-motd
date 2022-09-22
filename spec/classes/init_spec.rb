require 'spec_helper'
describe 'motd' do
  it { is_expected.to compile.with_all_deps }

  context 'with defaults for all parameters' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('motd') }

    it do
      is_expected.to contain_file('motd').with(
        {
          'ensure'  => 'file',
          'path'    => '/etc/motd',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'content' => nil,
        },
      )
    end

    it do
      is_expected.to contain_file('issue').with(
        {
          'ensure'  => 'file',
          'path'    => '/etc/issue',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'content' => nil,
        },
      )
    end

    it do
      is_expected.to contain_file('issue_net').with(
        {
          'ensure'  => 'file',
          'path'    => '/etc/issue.net',
          'owner'   => 'root',
          'group'   => 'root',
          'mode'    => '0644',
          'content' => nil,
        },
      )
    end
  end

  describe 'with invalid path' do
    ['motd', 'issue', 'issue_net'].each do |resource|
      context "specified for #{resource}_file" do
        let(:params) { { "#{resource}_file": 'invalid/path' } }

        it 'fail' do
          expect { is_expected.to contain_class(:subject) }.to raise_error(Puppet::Error)
        end
      end
    end
  end

  ensure_hash = {
    'motd_ensure' => {
      name: 'motd',
      path: '/etc/motd',
    },
    'issue_ensure' => {
      name: 'issue',
      path: '/etc/issue',
    },
    'issue_net_ensure' => {
      name: 'issue_net',
      path: '/etc/issue.net',
    },
  }

  ensure_hash.sort.each do |k, v|
    describe "with parameter #{k}" do
      ['file', 'present', 'absent'].each do |value|
        context "set to the valid value of #{value}" do
          let(:params) { { "#{k}": value } }

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('motd') }

          it do
            is_expected.to contain_file(v[:name]).with(
              {
                'ensure' => value,
                'path'   => v[:path],
                'owner'  => 'root',
                'group'  => 'root',
                'mode'   => '0644',
              },
            )
          end
        end
      end
    end
  end

  ['motd', 'issue', 'issue_net'].each do |resource|
    describe "#{resource} specified" do
      context 'with content specified' do
        let(:params) { { "#{resource}_content": 'foobar' } }

        it do
          is_expected.to contain_file(resource).with(
            {
              'ensure' => 'file',
              'owner'  => 'root',
              'group'  => 'root',
              'mode'   => '0644',
              'content' => %r{^foobar$},
            },
          )
        end
      end

      ['0775', '0664'].each do |mode|
        context "with mode set to valid value of #{mode}" do
          let(:params) { { "#{resource}_mode": mode } }

          it do
            is_expected.to contain_file(resource).with(
              {
                'ensure' => 'file',
                'owner'  => 'root',
                'group'  => 'root',
                'mode'   => mode,
              },
            )
          end
        end
      end
    end
  end

  describe 'variable type and content validations' do
    # set needed custom facts and variables
    let(:facts) { {} }
    let(:mandatory_params) { {} }

    validations = {
      'absolute_path' => {
        name:     ['motd_file', 'issue_file', 'issue_net_file'],
        valid:    ['/absolute/filepath', '/absolute/directory/'],
        invalid:  ['string', ['array'], { 'ha' => 'sh' }, 3, 2.42, true, false, nil],
        message:  '(expects a match for Variant\[Stdlib::Windowspath|expects a Stdlib::Absolutepath = Variant)', # Puppet 4|5
      },
      'regex ensure' => {
        name:     ['motd_ensure', 'issue_ensure', 'issue_net_ensure'],
        valid:    ['file', 'present', 'absent'],
        invalid:  ['string', ['array'], { 'ha' => 'sh' }, 3, 2.42, true, false, nil],
        message:  'match for Enum\[\'absent\', \'file\', \'present\'\]',
      },
      'regex file mode' => {
        name:     ['motd_mode', 'issue_mode', 'issue_net_mode'],
        valid:    ['0755', '0644', '1755', '0242'],
        invalid:  ['string', '755', 980, '0980', ['array'], { 'ha' => 'sh' }, 3, 2.42, true, false, nil],
        message:  'xpects a match for Stdlib::Filemode',
      },
    }

    validations.sort.each do |type, var|
      var[:name].each do |var_name|
        var[:params] = {} if var[:params].nil?
        var[:valid].each do |valid|
          context "when #{var_name} (#{type}) is set to valid #{valid} (as #{valid.class})" do
            let(:params) { [ var[:params], { "#{var_name}": valid, }].reduce(:merge) }

            it { is_expected.to compile }
          end
        end

        var[:invalid].each do |invalid|
          context "when #{var_name} (#{type}) is set to invalid #{invalid} (as #{invalid.class})" do
            let(:params) { [ var[:params], { "#{var_name}": invalid, }].reduce(:merge) }

            it 'fail' do
              expect { is_expected.to contain_class(:subject) }.to raise_error(Puppet::Error, %r{#{var[:message]}})
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'variable type and content validations'
end
