require 'spec_helper'

describe 'mariadbrepo' do

  ['Fedora', 'RedHat', 'CentOS'].each do |operatingsystem|
    ['5.5', '10.0'].each do |mariadb_release|
      ['i386', 'x86'].each do |architecure|
        context "Operating System #{operatingsystem} / MariaDB Release #{mariadb_release} / Architecture #{architecure}" do
          let(:facts) do
            { :operatingsystem => operatingsystem, :architecure => architecure }.merge default_facts
          end
          let(:params) do
            {'version' => mariadb_release}
          end
          it { should contain_file('/etc/yum.repos.d/mariadb.repo') }
        end
      end
    end
  end

end
