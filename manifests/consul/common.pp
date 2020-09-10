# Class: vision_hashicorp::consul::common
# ===========================
#
# Parameters
# ----------
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
