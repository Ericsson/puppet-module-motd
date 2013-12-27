# == Class: motd
#
# This module manages /etc/motd and /etc/issue.
# It is meant to be included in the common class that applies to all systems
#
# === Parameters
#
# motd_file
# ---------------------------
# Path to motd.
#
# - *Default*: '/etc/motd'
#
# motd_ensure
# ---------------------------
# ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.
#
# - *Default*: file
#
# motd_owner
# --------------------------
# motd's owner.
#
# - *Default*: 'root'
#
#
# motd_group
# --------------------------
# motd's group.
#
# - *Default*: 'root'
#
#
# motd_mode
# -------------------------
# motd's mode.
#
# - *Default*: '0644'
#
# motd_text
# -------------------------
# text to be put into motd file
#
# - *Default*:  ''
#
# issue_file
# ---------------------------
# Path to issue.
#
# - *Default*: '/etc/issue'
#
# issue_ensure
# ---------------------------
# ensure attribute for file resource. Valid values are 'file', 'present' and 'absent'.
#
# - *Default*: file
#
# issue_owner
# --------------------------
# issue's owner.
#
# - *Default*: 'root'
#
#
# issue_group
# --------------------------
# issue's group.
#
# - *Default*: 'root'
#
# issue_mode
# -------------------------
# issue's mode.
#
# - *Default*: '0644'
#
# issue_text
# -------------------------
# text to be put into issue file
#
# - *Default*:  ''
#
class motd (
  $motd_file    = '/etc/motd',
  $motd_ensure  = 'file',
  $motd_owner   = 'root',
  $motd_group   = 'root',
  $motd_mode    = '0644',
  $motd_text    = '',
  $issue_file   = '/etc/issue',
  $issue_ensure = 'file',
  $issue_owner  = 'root',
  $issue_group  = 'root',
  $issue_mode   = '0644',
  $issue_text   = '',
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

  file { 'motd':
    ensure  => $motd_ensure,
    path    => $motd_file,
    owner   => $motd_owner,
    group   => $motd_group,
    mode    => $motd_mode,
    content => template('motd/motd.erb')
  }

  file { 'issue':
    ensure  => $issue_ensure,
    path    => $issue_file,
    owner   => $issue_owner,
    group   => $issue_group,
    mode    => $issue_mode,
    content => template('motd/issue.erb')
  }
}
