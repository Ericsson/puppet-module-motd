# puppet-module-motd

Puppet module to manage /etc/motd and /etc/issue files

[![Build Status](https://travis-ci.org/Ericsson/puppet-module-motd.png?branch=master)](https://travis-ci.org/Ericsson/puppet-module-motd)

# Compatibility

This module supports Puppet v3 with Ruby 1.8.7, 1.9.3, and 2.0.0.

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
