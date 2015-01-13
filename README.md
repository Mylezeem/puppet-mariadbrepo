#puppet-mariadbrepo

[![Build Status](https://travis-ci.org/Mylezeem/puppet-mariadbrepo.svg?branch=master)](https://travis-ci.org/Mylezeem/puppet-mariadbrepo)

##Overview
A puppet module that configure the MariaDB repository on a Linux system.

**Notes**: EL7 will come with the MariaDB packages in its default repository, but this is not the case for EL5 and EL6.
This modules targets those specific platforms.

##Module Description
Based on your system specifications, this module will install a the repository to install MariaDB.

##Usage

As it simplest, simply include the `mariadbrepo` class

```puppet
include mariadbrepo
```

If one wants a specific version of MariaDB simply specify it (default is 10.0)

```puppet
class {'mariadbrepo' :
  version => '5.5',
}
```
##Parameters

####`version`

Version of MariaDB repo to install. Current Possible values are '5.5' or '10.0' (default)

##Limitations

This module works for :

* EL5
* EL6
* Fedora 19/20
* Debian 6/7
* Ubuntu 10.04/12.04/14.04/14.10
