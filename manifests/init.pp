# == Class: mariadbrepo
#
# A puppet module that configure the MariaDB repository on a Linux system.
#
# === Parameters
#
# [*ensure*]
#   (string) Should the repository file be present on the system
#   Default: 'present'
#
# [*mirror*]
#   (string) MariaDB mirror (apt only)
#   Default: 'http://ftp.osuosl.org/pub/mariadb'
#
# [*version*]
#   (float) MariaDB version number
#   Possible value: 5.5, 10.0
#   Default: 10.0
#
# === Examples
#
#  include mariadbrepo
#
#    or
#
#  class { mariadbrepo:
#   version => '5.5',
#  }
#
# === Authors
#
# Yanis Guenane <yguenane@gmail.com>
# Dimitri Savineau <savineau.dimitri@gmail.com>
#
# === Copyright
#
# Copyright 2014 Yanis Guenane
#
class mariadbrepo (
  $ensure  = 'present',
  $mirror  = 'http://ftp.osuosl.org/pub/mariadb',
  $version = '10.0',
) {

  $os = $::operatingsystem ? {
    'RedHat' => 'rhel',
    'CentOS' => 'centos',
    'Fedora' => 'fedora',
    'Debian' => 'debian',
    'Ubuntu' => 'ubuntu',
  }

  $os_ver = $::operatingsystemrelease ? {
    /7.[0-9]+/ => '7',
    /6.[0-9]+/ => '6',
    /5.[0-9]+/ => '5',
    default    => $::operatingsystemrelease,
  }

  $arch = $::architecture ? {
    'i386'   => 'x86',
    'x86_64' => 'amd64',
    default  => $::architecture,
  }

  case $::operatingsystem {
    'RedHat','CentOS','Fedora': {
      yumrepo { 'MariaDB' :
        ensure   => $ensure,
        descr    => 'MariaDB',
        baseurl  => "http://yum.mariadb.org/${version}/${os}${os_ver}-${arch}",
        gpgkey   => 'https://yum.mariadb.org/RPM-GPG-KEY-MariaDB',
        gpgcheck => 1,
      }
    }
    'Debian','Ubuntu': {
      apt::source { 'MariaDB':
        ensure     => $ensure,
        location   => "${mirror}/repo/${version}/${os}",
        release    => $::lsbdistcodename,
        repos      => 'main',
        key        => '1BB943DB',
        key_server => 'keyserver.ubuntu.com',
      }
    }
    default: {
      fail ("This module does not support your operating system : ${::operatingsystem}")
    }
  }

}
