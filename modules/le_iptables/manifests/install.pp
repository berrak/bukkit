##
## This class manage iptables
##
class le_iptables::install {

    package  { 'iptables' :
                ensure => installed }
				
	file { "/etc/rc.local" :
		 source => "puppet:///modules/le_iptables/rc.local",
		  owner => 'root',
		  group => 'root',
		   mode => '0700',
		require => Package["iptables"],
	}
	
    package { "fail2ban":
				 ensure => installed,
				require => Package["iptables"],
	}	

}
