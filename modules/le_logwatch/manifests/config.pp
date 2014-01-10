##
##  Configure logwatch
##
class le_logwatch::config {
 
 
	file { "/etc/logwatch/logwatch.conf":
		source => "puppet:///modules/le_logwatch/logwatch.conf",
		 owner => 'root',
		 group => 'root',
		  mode => '0644',
	   require => Package["logwatch"],
    }
	
}