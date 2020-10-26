# Class: vision_hashicorp::repo
# ===========================
#
# Parameters
# ----------
#
# @param repo_key Key for the Hashicorp Apt repository
# @param repo_key_id Key ID for the Hashicorp Apt repository
#
# Examples
# --------
#
# @example
# contain ::vision_hashicorp::repo
#

class vision_hashicorp::repo (

  String $repo_key,
  String $repo_key_id,

) {

  apt::source { 'hashicorp':
    location => 'https://apt.releases.hashicorp.com',
    repos    => 'main',
    key      => {
      id      => $repo_key_id,
      content => $repo_key,
    },
    include  => {
      'src' => false,
      'deb' => true,
    },
    pin      => '500',
  }
  -> exec { 'hashicorp-update':
    command     => '/usr/bin/apt-get update',
    logoutput   => 'on_failure',
    refreshonly => true,
  }

}
