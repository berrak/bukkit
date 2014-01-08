##
## This class manage iptables
##
class le_iptables {

    include le_fail2ban
	include le_iptables::install, le_iptables::config
	
}
