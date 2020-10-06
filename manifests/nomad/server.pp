# Class: vision_hashicorp::nomad::server
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_hashicorp::nomad::server
#

class vision_hashicorp::nomad::server (

  Array $retry_join,
  Sensitive[String] $encrypt,
  String $advertise_addr = $::ipaddress,

) {

  contain vision_hashicorp::repo

  package { 'nomad':
    ensure  => present,
    require => Class['vision_hashicorp::repo'],
  }

  file { '/etc/nomad.d/nomad.hcl':
    ensure  => present,
    owner   => 'nomad',
    group   => 'nomad',
    mode    => '0640',
    content => template('vision_hashicorp/nomad/server.hcl.erb'),
    require => Package['nomad'],
    notify  => Service['nomad'],
  }

  file { '/etc/nomad.d/anonymous.policy':
    ensure  => present,
    owner   => 'nomad',
    group   => 'nomad',
    mode    => '0640',
    content => file('vision_hashicorp/nomad/anonymous.policy'),
    require => Package['nomad'],
  }

  # Hint: Nomad OpenSource only supports the default namespace
  file { '/etc/nomad.d/default.policy':
    ensure  => present,
    owner   => 'nomad',
    group   => 'nomad',
    mode    => '0640',
    content => file('vision_hashicorp/nomad/default.policy'),
    require => Package['nomad'],
  }

  service { 'nomad':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package['nomad'],
  }

}
