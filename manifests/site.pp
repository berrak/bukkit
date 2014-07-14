#
# site.pp
#
node 'www-node.debinix.org' {
    
    include puppetize
    
    ### modules from bukkit repo ###	
	
    include le_root_home
    include le_screen
	include le_logwatch
	
	# ntp server provids time services
    class { 'le_ntp' : role => 'lanserver', peerntpip => '217.70.39.231' }	
        
    class { le_hosts::config : puppetserver_hostname => 'www' }
	
	# installs iptables + fail2ban
	# enable fail2ban apache and modsec regexp ban actions, these
	# latter two parameters needs both apache and mod-security installed
    class { le_iptables::config :
		puppetserver_hostname => 'www',
		      fail2ban_apache => 'true',
		      fail2ban_modsec => 'true',
	}
    
    ### modules from homepup2 repo ###		
	
	le_postfix::install { 'mta' :
			            ensure => 'installed',
			install_cyrus_sasl => 'true',
			          mta_type => 'server',
		 server_root_mail_user => 'bekr',			  
		   smtp_relayhost_fqdn => 'smtp.debinix.org',
		  no_lan_outbound_mail => 'false',
	}
	
    ### modules from virtualhost repo ###
    
    include vb_puppet_utils
    
    include vb_root_bashrc
    
    # configure APT
    include vb_aptconf
    
    # use apache2 prefork
    include vb_apache2 
    	
	## Define a new Apache2 virtual host (docroot directory writable by group 'root')
    vb_apache2::vhost { 'www.debinix.org' :
            priority => '001',
          devgroupid => 'root',
          execscript => 'none',
    }
	
	## Add mod-security for Apache (+ module headers)
	vb_apache2::module { 'mod-security' : }
	vb_apache2::module { 'headers' : }	
	
    # user profile
    vb_user_bashrc::config { 'bekr' : }
    
}
