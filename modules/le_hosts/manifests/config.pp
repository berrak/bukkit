##
## This class manage hosts
## 
class le_hosts::config ( $puppetserver_hostname = '' ) {
		
	case $::hostname {
    
        $puppetserver_hostname : {
		
            file { "/etc/hosts" :
                 source => "puppet:///modules/le_hosts/kronlund01_hosts",
                  owner => 'root',
                  group => 'root',
                   mode => '0644',
            }
        
        }
		
        default: { fail("FAIL: Hostname ${puppetserver_hostname} unknown. Aborting...") }
	
	}
	
}
