#puppet-mariadbrepo

[![Build Status](https://travis-ci.org/Mylezeem/puppet-mariadbrepo.svg?branch=master)](https://travis-ci.org/Mylezeem/puppet-mariadbrepo)

##Overview
A puppet module that configure the MariaDB repository on an Enterprise Linux (and relatives) system

**Notes**: EL7 will come with the MariaDB packages in its default repository, but this is not the case for EL5 and EL6.
This modules targets those specific platforms.

##Module Description
Based on your system specifications, this module will install a the repository to install MariaDB.

**Notes**: As specified in the description, it works only for Enterprise Linux and its relatives.

##Usage

As it simplest, simply include the `mariadbrepo` class

```puppet
include mariadbrepo
```

If one wants a specific version of MariaDB simply specify it (defaul is 10.0)

```puppet
class {'mariadbrepo' :
  version => '5.5',
}
```

##Limitations

This module works for :

* EL5
* EL6
* Fedora 19/20

