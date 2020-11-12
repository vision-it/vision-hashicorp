# Class: vision_hashicorp::consul::server
# ===========================
#
# Parameters
# ----------
#
# @param retry_join List of Consul servers to connect to.
# @param encrypt Secret key to use for encryption of Consul network traffic.
# @param advertise_addr Address to bind to.
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
  contain vision_hashicorp::dnsmasq
  contain vision_hashicorp::consul::common

  # /etc/consul.d needs to be created first
  Package['consul']
  -> Class['vision_hashicorp::consul::common']

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
    ensure     => running,
    enable     => true,
    hasrestart => true,
    subscribe  => Class['vision_hashicorp::consul::common'],
    require    => Package['consul'],
  }

}
