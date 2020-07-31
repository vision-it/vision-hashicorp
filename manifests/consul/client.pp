# Class: vision_hashicorp::consul::client
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_hashicorp::consul::client
#

class vision_hashicorp::consul::client (

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
    mode    => '0640',
    content => template('vision_hashicorp/consul/client.hcl.erb'),
    require => Package['consul'],
  }

  service { 'consul':
    ensure => running,
    enable => true,
  }

  # TODO: dnsmasq
  # See https://gluster.readthedocs.io/en/latest/Administrator%20Guide/Consul/

}
