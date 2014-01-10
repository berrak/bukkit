##
## This class manage iptables
##
class le_iptables {

	include le_iptables::install, le_iptables::config, le_iptables::service
	
}
