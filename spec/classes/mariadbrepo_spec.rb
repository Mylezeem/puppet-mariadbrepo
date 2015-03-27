require 'spec_helper'

describe 'mariadbrepo' do

  ['Fedora', 'RedHat', 'CentOS', 'Debian', 'Ubuntu'].each do |operatingsystem|
    ['5.5', '10.0'].each do |mariadb_release|
      ['i386', 'x86_64'].each do |architecture|
        ['present', 'absent'].each do |package_ensure|

          context "Operating System #{operatingsystem} / MariaDB Release #{mariadb_release} / Architecture #{architecture} / Ensure #{package_ensure}" do

            case operatingsystem
            when 'Fedora'
              os        = 'fedora'
              vers_maj  = '20'
              vers_full = '20'
            when 'RedHat'
              os        = 'rhel'
              vers_maj  = '6'
              vers_full = '6.5'
            when 'CentOS'
              os        = 'centos'
              vers_maj  = '6'
              vers_full = '6.5'
            when 'Debian'
              os        = 'debian'
              codename  = 'wheezy'
            when 'Ubuntu'
              os        = 'ubuntu'
              codename  = 'precise'
            end

            case architecture
            when 'i386'
              arch = 'x86'
            when 'x86_64'
              arch = 'amd64'
            end

            let(:facts) do
              {
                :operatingsystem        => operatingsystem,
                :operatingsystemrelease => vers_full,
                :architecture           => architecture,
                :lsbdistcodename        => codename,
                :lsbdistid              => "#{operatingsystem}"
              }
            end

            let(:params) do
              {
                :version => mariadb_release,
                :ensure  => package_ensure,
              }
            end

            case operatingsystem
            when 'Fedora','RedHat','CentOS'
              it {
                should contain_yumrepo('MariaDB').with({
                  'ensure'   => package_ensure,
                  'descr'    => 'MariaDB',
                  'baseurl'  => "http://yum.mariadb.org/#{mariadb_release}/#{os}#{vers_maj}-#{arch}",
                  'gpgkey'   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
                  'gpgcheck' => '1',
                })
              }
            when
              it {
                should contain_apt__source('MariaDB').with({
                  'ensure'     => package_ensure,
                  'location'   => "http://ftp.osuosl.org/pub/mariadb/repo/#{mariadb_release}/#{os}",
                  'release'    => "#{codename}",
                  'repos'      => 'main',
                  'key'        => '1BB943DB',
                  'key_server' => 'keyserver.ubuntu.com',
                })
              }
            end
          end
        end
      end
    end
  end

end
