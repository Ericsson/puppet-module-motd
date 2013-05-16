# puppet-module-motd #

Puppet module to manage /etc/motd and /etc/issue files

# Parameters #

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

motd_text
---------
text to be put into motd file

- *Default*:  ''

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

issue_text
----------
text to be put into issue file

- *Default*:  ''

