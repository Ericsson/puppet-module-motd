# puppet-module-motd

Puppet module to manage /etc/motd and /etc/issue files

[![Build Status](https://travis-ci.org/Ericsson/puppet-module-motd.png?branch=master)](https://travis-ci.org/Ericsson/puppet-module-motd)

# Compatibility

This module is built for use with Puppet v3 (with and without the future
parser) and Puppet v4 on the following platforms and supports Ruby versions
1.8.7, 1.9.3, 2.0.0 and 2.1.0.

* Debian 5
* Debian 6
* Debian 7
* EL 5
* EL 6
* EL 7
* Solaris 9
* Solaris 10
* Solaris 11
* Suse 10 (SLED/SLES)
* Suse 11 (SLED/SLES)
* Suse 12 (SLED/SLES)
* Ubuntu 12.04 LTS
* Ubuntu 14.04 LTS


# Parameters

motd_file
---------
Path to motd.

- *Default*: '/etc/motd'

motd_ensure
-----------
ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.

- *Default*: file

motd_owner
----------
motd's owner.

- *Default*: 'root'


motd_group
----------
motd's group.

- *Default*: 'root'


motd_mode
---------
motd's mode.

- *Default*: '0644'

motd_content
---------
content of motd file

- *Default*: undef

issue_file
----------
Path to issue.

- *Default*: '/etc/issue'

issue_ensure
------------
ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.

- *Default*: file

issue_owner
-----------
issue's owner.

- *Default*: 'root'

issue_group
-----------
issue's group.

- *Default*: 'root'

issue_mode
----------
issue's mode.

- *Default*: '0644'

issue_content
----------
content of issue file

- *Default*: undef

issue_net_file
--------------
Path to issue.net.

- *Default*: '/etc/issue.net'

issue_net_ensure
----------------
ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.

- *Default*: file

issue_net_owner
---------------
issue.net's owner.

- *Default*: 'root'

issue_net_group
---------------
issue.net's group.

- *Default*: 'root'

issue_net_mode
--------------
issue.net's mode.

- *Default*: '0644'

issue_net_content
--------------
content of issue.net file

- *Default*:  undef
