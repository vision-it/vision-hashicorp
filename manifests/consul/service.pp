# Define: vision_hashicorp::consul::service
# ===========================
#
# Creates a Consul Service
#
# Parameters
# ----------
#

define vision_hashicorp::consul::service (

  Integer $port,
  Optional[String] $address = undef,
  Array $tags = [],
  Array[Hash] $checks = [],
  String $service_name = $title,
  String $service_id = "${::hostname}-${title}",

) {

  file { "/etc/consul.d/service_${title}.json":
    ensure  => present,
    owner   => 'consul',
    group   => 'consul',
    mode    => '0640',
    content => template('vision_hashicorp/consul/service.json.erb'),
  }

}
