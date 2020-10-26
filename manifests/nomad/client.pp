# Class: vision_hashicorp::nomad::client
# ===========================
#
# Parameters
# ----------
#
# @param retry_join List of Nomad servers to connect to.
# @param advertise_addr Address to bind to.
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

  # Deploy customized Service Unit, for Consul and DNS adjustments.
  file { '/etc/systemd/system/nomad.service':
    ensure  => present,
    mode    => '0644',
    content => file('vision_hashicorp/nomad/nomad.service'),
    require => Package['nomad'],
    notify  => Service['nomad'],
  }

  service { 'nomad':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => [
      Package['nomad'],
      File['/etc/systemd/system/nomad.service'],
    ],
  }

}
