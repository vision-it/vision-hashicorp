# Class: vision_hashicorp::consul::common
# ===========================
#
# Parameters
# ----------
#
# @param services List of Consul service files to create
#
# Examples
# --------
#
# @example
# contain ::vision_hashicorp::consul::common
#

class vision_hashicorp::consul::common (

  Optional[Hash] $services = {},

) {

  create_resources('vision_hashicorp::consul::service', $services)

}
