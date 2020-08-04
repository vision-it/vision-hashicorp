# Class: vision_hashicorp::dnsmasq
# ===========================
#
# Parameters
# ----------
#
# Examples
# --------
#
# @example
# contain ::vision_hashicorp::dnsmasq
#

class vision_hashicorp::dnsmasq (

) {

  # DNS Service to ensure other applications can access it via port 53
  package { 'dnsmasq':
    ensure => present,
  }

  file { '/etc/dnsmasq.d/10-consul':
    ensure  => present,
    mode    => '0644',
    content => 'server=/consul/127.0.0.1#8600',
    require => Package['dnsmasq'],
    notify  => Service['dnsmasq'],
  }

  file { '/etc/dnsmasq.conf':
    ensure  => present,
    mode    => '0644',
    content => file('vision_hashicorp/consul/dnsmasq.conf'),
    require => Package['dnsmasq'],
    notify  => Service['dnsmasq'],
  }

  service { 'dnsmasq':
    ensure  => running,
    enable  => true,
    require => [
      File['/etc/dnsmasq.conf'],
      File['/etc/dnsmasq.d/10-consul'],
    ]
  }

  file_line { 'consul_dns':
    path   => '/etc/resolv.conf',
    after  => 'search.*',
    line   => 'nameserver 127.0.0.1',
    notify => Service['dnsmasq'],
  }

}
