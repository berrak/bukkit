#
# site.pp
#
node 'www-node.mc-butter.se' {
    
    include puppetize
    
    include le_root_home
    include le_screen
	include le_logwatch
	
	# ntp server provids time services
    class { 'puppet_ntp' : role => 'lanserver', peerntpip => '217.70.39.231' }	
        
    class { le_hosts::config : puppetserver_hostname => 'www' }
	
	# installs iptables + fail2ban
    class { le_iptables::config : puppetserver_hostname => 'www' }
    
    ## modules from virtualhost repo ##
    
    include vb_puppet_utils
    
    # packages without any special configurations
    class { vb_install_debs : debs => [ "build-essential", "tree", "dnsutils", "locales-all" ] }    
    
    include vb_root_bashrc
    
    # configure APT
    include vb_aptconf
    
    # use apache2 prefork
    include vb_apache2 
    
    # Define a new Apache2 virtual host (suexec to user jensen)    
    vb_apache2::vhost { 'www.mc-butter.se' :
            priority => '001',
          devgroupid => 'jensen',
         execscript => 'suexec',
    }        
    
    # user profile
    vb_user_bashrc::config { 'jensen' : }
    
    # postgreSQL-9.1
    include vb_postgresql
    
	# Create database for the application and owner (option: 2nd databaseuser)
    vb_postgresql::create_database { 'openjensen' :
		databaseowner => 'jensen',
		databaseuser => '' }	    
    
    # partial install for OC-ESQL pre-compiler. The source 
    # OSS Consortium archieve have to be installed manually
    include vb_ocesql
    
    
    ## set up project structure (no spaces in names) and makefiles
    
    class { le_build::project :
      projectname => 'openjensen',
		 username => 'jensen',
        groupname => 'jensen',
    }
    
    le_build::make { 'src' :
     	projectname => 'openjensen',
		   username => 'jensen',
          groupname => 'jensen',
    }
    
    le_build::make { 'html' :
     	projectname => 'openjensen',
		   username => 'jensen',
          groupname => 'jensen',
    }
    
    le_build::make { 'lib' :
     	projectname => 'openjensen',
		   username => 'jensen',
          groupname => 'jensen',
    }    
    
    # Ensure daily cron backup
    
    le_build::backup { 'jensen' : projectname => 'openjensen' }     
    
}
