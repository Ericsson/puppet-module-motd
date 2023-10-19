# Puppet module to manage /etc/motd and /etc/issue files
#
# @param motd_file
#   Path to motd.
#
# @param motd_ensure
#   Ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.
#
# @param motd_owner
#   motd owner.
#
# @param motd_group
#   motd group.
#
# @param motd_mode
#   motd mode.
#
# @param motd_content
#   Content of motd file.
#
# @param motd_directory_ensure
#   Ensure attribute for directory resource. Valid values are 'directory' and 'absent'
#
# @param motd_directory
#   Path to MOTD directory
#
# @param motd_directory_owner
#   motd directory owner
#
# @param motd_directory_group
#   motd directory group
#
# @param motd_directory_mode
#   motd directory mode
#
# @param motd_directory_purge
#   Sets whether to purge unmanaged files under motd module_directory
#
# @param issue_file
#   Path to issue.
#
# @param issue_ensure
#   Ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.
#
# @param issue_owner
#   issue owner.
#
# @param issue_group
#   issue group.
#
# @param issue_mode
#   issue mode.
#
# @param issue_content
#   Content of issue file.
#
# @param issue_net_file
#   Path to issue.net.
#
# @param issue_net_ensure
#   Ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.
#
# @param issue_net_owner
#   issue.net owner.
#
# @param issue_net_group
#   issue.net group.
#
# @param issue_net_mode
#   issue.net mode.
#
# @param issue_net_content
#   Content of issue.net file
#
class motd (
  Stdlib::Absolutepath              $motd_file         = '/etc/motd',
  Enum['file', 'present', 'absent'] $motd_ensure       = 'file',
  String[1]                         $motd_owner        = 'root',
  String[1]                         $motd_group        = 'root',
  Stdlib::Filemode                  $motd_mode         =  '0644',
  Optional[String[1]]               $motd_content      = undef,
  Enum['directory', 'absent']       $motd_directory_ensure  = 'directory',
  Stdlib::Absolutepath              $motd_directory         = '/etc/motd.d',
  String[1]                         $motd_directory_owner   = 'root',
  String[1]                         $motd_directory_group   = 'root',
  Stdlib::Filemode                  $motd_directory_mode    =  '0755',
  Boolean                           $motd_directory_purge   = true,
  Stdlib::Absolutepath              $issue_file        = '/etc/issue',
  Enum['file', 'present', 'absent'] $issue_ensure      = 'file',
  String                            $issue_owner       = 'root',
  String                            $issue_group       = 'root',
  Stdlib::Filemode                  $issue_mode        = '0644',
  Optional[String[1]]               $issue_content     = undef,
  Stdlib::Absolutepath              $issue_net_file    = '/etc/issue.net',
  Enum['file', 'present', 'absent'] $issue_net_ensure  = 'file',
  String[1]                         $issue_net_owner   = 'root',
  String[1]                         $issue_net_group   = 'root',
  Stdlib::Filemode                  $issue_net_mode    = '0644',
  Optional[String[1]]               $issue_net_content = undef,
) {
  file { 'motd':
    ensure  => $motd_ensure,
    path    => $motd_file,
    owner   => $motd_owner,
    group   => $motd_group,
    mode    => $motd_mode,
    content => $motd_content,
  }

  file { 'motd.d':
    ensure  => $motd_directory_ensure,
    path    => $motd_directory,
    owner   => $motd_directory_owner,
    group   => $motd_directory_group,
    mode    => $motd_directory_mode,
    purge   => $motd_directory_purge,
    force   => $motd_directory_purge,
    recurse => $motd_directory_purge,
  }

  file { 'issue':
    ensure  => $issue_ensure,
    path    => $issue_file,
    owner   => $issue_owner,
    group   => $issue_group,
    mode    => $issue_mode,
    content => $issue_content,
  }

  file { 'issue_net':
    ensure  => $issue_net_ensure,
    path    => $issue_net_file,
    owner   => $issue_net_owner,
    group   => $issue_net_group,
    mode    => $issue_net_mode,
    content => $issue_net_content,
  }
}
