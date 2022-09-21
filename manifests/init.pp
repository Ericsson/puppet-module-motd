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
  Stdlib::Absolutepath $motd_file                     = '/etc/motd',
  Enum['file', 'present', 'absent'] $motd_ensure      = 'file',
  String $motd_owner                                  = 'root',
  String $motd_group                                  = 'root',
  Pattern[/^[0-7]{4}$/] $motd_mode                    = '0644',
  Optional[String] $motd_content                      = undef,
  Stdlib::Absolutepath $issue_file                    = '/etc/issue',
  Enum['file', 'present', 'absent'] $issue_ensure     = 'file',
  String $issue_owner                                 = 'root',
  String $issue_group                                 = 'root',
  Pattern[/^[0-7]{4}$/] $issue_mode                   = '0644',
  Optional[String] $issue_content                     = undef,
  Stdlib::Absolutepath $issue_net_file                = '/etc/issue.net',
  Enum['file', 'present', 'absent'] $issue_net_ensure = 'file',
  String $issue_net_owner                             = 'root',
  String $issue_net_group                             = 'root',
  Pattern[/^[0-7]{4}$/] $issue_net_mode               = '0644',
  Optional[String] $issue_net_content                 = undef,
) {
  file { 'motd':
    ensure  => $motd_ensure,
    path    => $motd_file,
    owner   => $motd_owner,
    group   => $motd_group,
    mode    => $motd_mode,
    content => $motd_content,
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
