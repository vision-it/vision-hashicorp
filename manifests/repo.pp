# Class: vision_hashicorp::repo
# ===========================
#
# Parameters
# ----------
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
    }
  }

}
