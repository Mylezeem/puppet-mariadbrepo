require 'spec_helper'

describe 'mariadbrepo' do

  ['Fedora', 'RedHat', 'CentOS'].each do |operatingsystem|
    ['5.5', '10.0'].each do |mariadb_release|
      ['i386', 'x86_64'].each do |architecture|

        context "Operating System #{operatingsystem} / MariaDB Release #{mariadb_release} / Architecture #{architecture}" do

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
            os   = 'centos'
            vers_maj  = '6'
            vers_full = '6.5'
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
            }
          end

          let(:params) do
            {
              :version => mariadb_release,
            }
          end

          it {
            should contain_yumrepo('MariaDB').with({
              'descr'    => 'MariaDB',
              'baseurl'  => "http://yum.mariadb.org/#{mariadb_release}/#{os}#{vers_maj}-#{arch}",
              'gpgkey'   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
              'gpgcheck' => '1',
            })
          }

        end
      end
    end
  end

end
