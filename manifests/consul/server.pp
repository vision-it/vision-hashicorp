# Class: vision_hashicorp::consul::server
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_hashicorp::consul::server
#

class vision_hashicorp::consul::server (

  Array $retry_join,
  Sensitive[String] $encrypt,
  String $advertise_addr = $::ipaddress,

) {

  contain vision_hashicorp::repo

  package { 'consul':
    ensure  => present,
    require => Class['vision_hashicorp::repo'],
  }

  file { '/etc/consul.d/consul.hcl':
    ensure  => present,
    owner   => 'consul',
    group   => 'consul',
    mode    => '0640',
    content => template('vision_hashicorp/consul/server.hcl.erb'),
    notify  => Service['consul'],
    require => Package['consul'],
  }

  service { 'consul':
    ensure  => running,
    enable  => true,
    require => Package['consul'],
  }

}
