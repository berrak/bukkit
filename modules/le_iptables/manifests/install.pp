##
## This class manage iptables
##
class le_iptables::install {

    package  { 'iptables' :
                ensure => installed }

	file { "/etc/rc.local" :
		 source => "puppet:///modules/puppet_iptables/rc.local",
		  owner => 'root',
		  group => 'root',
		   mode => '0700',
		require => Package["iptables"],
	}	

}
