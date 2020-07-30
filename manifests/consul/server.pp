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

) {

  contain vision_hashicorp::repo

  package { 'consul':
    ensure  => present,
    require => Class['vision_hashicorp::repo'],
  }

  file { '/etc/consul.d/consul.hcl':
    ensure  => present,
    mode    => '0640',
    content => template('vision_hashicorp/consul/server.hcl.erb'),
    require => Package['consul'],
  }

  service { 'consul':
    ensure => running,
    enable => true,
  }

}
