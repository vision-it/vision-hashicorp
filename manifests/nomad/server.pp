# Class: vision_hashicorp::nomad::server
# ===========================
#
# Parameters
# ----------
#
# @param retry_join List of Nomad servers to connect to.
# @param encrypt Secret key to use for encryption of Nomad network traffic.
# @param advertise_addr Address to bind to.
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

  file { '/etc/nomad.d/ci.policy':
    ensure  => present,
    owner   => 'nomad',
    group   => 'nomad',
    mode    => '0640',
    content => file('vision_hashicorp/nomad/ci.policy'),
    require => Package['nomad'],
  }

  file { '/etc/nomad.d/operator.policy':
    ensure  => present,
    owner   => 'nomad',
    group   => 'nomad',
    mode    => '0640',
    content => file('vision_hashicorp/nomad/operator.policy'),
    require => Package['nomad'],
  }

  service { 'nomad':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package['nomad'],
  }

}
