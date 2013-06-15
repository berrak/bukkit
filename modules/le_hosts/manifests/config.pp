##
## This class manage the setting in each node host file.
## 
class admin_hosts::config ( $puppetserver_hostname = '' ) {
		
	case $::hostname {
    
        $puppetserver_hostname : {
		
            file { '/etc/hosts' :
                 ensure => present,
                 source => "puppet:///modules/le_hosts/$puppetserver_hostname_hosts",
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
