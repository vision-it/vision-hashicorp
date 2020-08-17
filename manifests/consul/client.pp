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
  Optional[Hash] $services = {},

) {

  contain vision_hashicorp::repo
  contain vision_hashicorp::dnsmasq

  package { 'consul':
    ensure  => present,
    require => Class['vision_hashicorp::repo'],
  }

  file { '/etc/consul.d/consul.hcl':
    ensure  => present,
    owner   => 'consul',
    group   => 'consul',
    mode    => '0640',
    content => template('vision_hashicorp/consul/client.hcl.erb'),
    notify  => Service['consul'],
    require => Package['consul'],
  }

  service { 'consul':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => Package['consul'],
  }

  create_resources('vision_hashicorp::consul::service', $services)

}
