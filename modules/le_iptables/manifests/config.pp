##
## This class manage iptables
## 
class le_iptables::config ( $puppetserver_hostname = '',
                            $fail2ban_apache = 'false',
							$fail2ban_modsec = 'false',
							$fail2ban_postfix = 'false',
) {
		
	include le_iptables
	
	$mydomain = $::domain
	
	case $::hostname {
    
        $puppetserver_hostname : {
		
            file { "/root/bin/fw.levonline.server" :
                 source => "puppet:///modules/le_iptables/fw.levonline.server",
                  owner => 'root',
                  group => 'root',
                   mode => '0700',
		        require => File["/root/bin"],
		         notify => Exec["/bin/sh /root/bin/fw.levonline.server"],
            }
			
            exec { "/bin/sh /root/bin/fw.levonline.server":
				refreshonly => true,
				     notify => Service["fail2ban"],
            }
						
            file { "/etc/fail2ban/jail.local":
				   content =>  template( "le_iptables/jail.local.erb" ),
					 owner => 'root',
					 group => 'root',
					  mode => '0640',
				   require => Package["fail2ban"],
					notify => Service["fail2ban"],
            }			
			
        
        }
		
        default: { fail("FAIL: Hostname ${puppetserver_hostname} unknown. Aborting...") }
	
	}
	
}
