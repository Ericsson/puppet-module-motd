# == Class: motd
#
# This module manages /etc/motd and /etc/issue.
#
class motd (
  $motd_file         = '/etc/motd',
  $motd_ensure       = 'file',
  $motd_owner        = 'root',
  $motd_group        = 'root',
  $motd_mode         = '0644',
  $motd_content      = undef,
  $issue_file        = '/etc/issue',
  $issue_ensure      = 'file',
  $issue_owner       = 'root',
  $issue_group       = 'root',
  $issue_mode        = '0644',
  $issue_content     = undef,
  $issue_net_file    = '/etc/issue.net',
  $issue_net_ensure  = 'file',
  $issue_net_owner   = 'root',
  $issue_net_group   = 'root',
  $issue_net_mode    = '0644',
  $issue_net_content = undef,
) {

  # Validates $motd_ensure
  case $motd_ensure {
    'file', 'present', 'absent': {
      # noop, these values are valid
    }
    default: {
      fail("Valid values for \$motd_ensure are \'absent\', \'file\', or \'present\'. Specified value is ${motd_ensure}")
    }
  }

  # Validates $issue_ensure
  case $issue_ensure {
    'file', 'present', 'absent': {
      # noop, these values are valid
    }
    default: {
      fail("Valid values for \$issue_ensure are \'absent\', \'file\', or \'present\'. Specified value is ${issue_ensure}")
    }
  }

  # Validates $issue_net_ensure
  case $issue_net_ensure {
    'file', 'present', 'absent': {
      # noop, these values are valid
    }
    default: {
      fail("Valid values for \$issue_ensure are \'absent\', \'file\', or \'present\'. Specified value is ${issue_net_ensure}")
    }
  }

  validate_absolute_path($motd_file)
  validate_absolute_path($issue_file)
  validate_absolute_path($issue_net_file)

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

  file { 'issue.net':
    ensure  => $issue_net_ensure,
    path    => $issue_net_file,
    owner   => $issue_net_owner,
    group   => $issue_net_group,
    mode    => $issue_net_mode,
    content => $issue_net_content,
  }
}
