##
## This class manage the setting in each node host file.
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
		
        default: {
              fail("Fail: Hostname ${puppetserver_hostname} unknown. Aborting...")
        }
	
	}
	
}
