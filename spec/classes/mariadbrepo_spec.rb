require 'spec_helper'

describe 'mariadbrepo' do

  ['Fedora', 'RedHat', 'CentOS'].each do |operatingsystem|
    ['5.5', '10.0'].each do |mariadb_release|
      ['i386', 'x86_64'].each do |architecture|
        context "Operating System #{operatingsystem} / MariaDB Release #{mariadb_release} / Architecture #{architecture}" do
          let(:facts) do
            { :operatingsystem => operatingsystem, :architecture => architecture }
          end
          let(:params) do
            {'version' => mariadb_release,
             'repo_desc_path' => '/etc/yum.repos.d'}
          end
          it { should contain_file('/etc/yum.repos.d/mariadb.repo') }
        end
      end
    end
  end

end
