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
    class { le_iptables::config : puppetserver_hostname => 'www' }
    
	
	
    ### modules from virtualhost repo ###
    
    include vb_puppet_utils
    
    include vb_root_bashrc
    
    # configure APT
    include vb_aptconf
    
    # use apache2 prefork
    include vb_apache2 
    	
	## Define a new Apache2 virtual host (docroot directory writable by group 'bekr')
    vb_apache2::vhost { 'debinix.org' :
            priority => '001',
          devgroupid => 'bekr',
          execscript => 'none',
    }
	
    # user profile
    vb_user_bashrc::config { 'bekr' : }
    
}
