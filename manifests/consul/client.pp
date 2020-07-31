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
    owner   => 'consul',
    group   => 'consul',
    mode    => '0640',
    content => template('vision_hashicorp/consul/client.hcl.erb'),
    require => Package['consul'],
  }

  service { 'consul':
    ensure => running,
    enable => true,
  }

  # DNS Service to ensure other applications can access it via port 53
  package { 'dnsmasq':
    ensure => present,
  }

  file { '/etc/dnsmasq.d/10-consul':
    ensure  => present,
    mode    => '0644',
    content => 'server=/consul/127.0.0.1#8600',
    require => Package['dnsmasq'],
  }

  # TODO: Adjust resolv.conf
  # Maybe /etc/dhcp/dhclient.conf
}
