# Class: vision_hashicorp::nomad::client
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_hashicorp::nomad::client
#

class vision_hashicorp::nomad::client (

  Array $retry_join,
  String $advertise_addr = $::ipaddress,

) {

  contain vision_hashicorp::repo

  package { 'nomad':
    ensure  => present,
    require => Class['vision_hashicorp::repo'],
  }

  file { '/etc/nomad.d/nomad.hcl':
    ensure  => present,
    mode    => '0640',
    content => template('vision_hashicorp/nomad/client.hcl.erb'),
    require => Package['nomad'],
    notify  => Service['nomad'],
  }

  service { 'nomad':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package['nomad'],
  }

}
