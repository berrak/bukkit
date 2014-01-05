##
##  Configure fail2ban
##
class le_fail2ban::config {
 
 
	file { "/etc/fail2ban/jail.local":
		source => "puppet:///modules/le_fail2ban/jail.local",
		 owner => 'root',
		 group => 'root',
		  mode => '0640',
	   require => Package["fail2ban"],
        notify => Service["fail2ban"],
    }
	
}