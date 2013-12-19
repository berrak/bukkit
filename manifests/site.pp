#
# site.pp
#
node 'kronlund01.levonline.com' {
    
    include puppetize
    
    include vb_puppet_utils
    
    include le_root_home
    include le_screen
        
    class { le_hosts::config : puppetserver_hostname => 'kronlund01' }
    class { le_iptables::config : puppetserver_hostname => 'kronlund01' }
    
    
    
    ## modules from virtualhost repo ##
    
    include vb_root_bashrc
    
    # configure APT
    include vb_aptconf
    
    # use apache2 prefork
    include vb_apache2
    
    # Define a new Apache2 virtual host (suexec to user jensen)    
    vb_apache2::vhost { 'jensen.mc-butter.se' :
            priority => '001',
          devgroupid => 'jensen',
          execscript => 'suexec',
    }        
    
    # user profile
    vb_user_bashrc::config { 'jensen' : }
    
    # postgreSQL-9.1
    include vb_postgresql
    
    # packages without any special configurations
    class { vb_install_debs : debs => [ "build-essential", "tree" ] }
    
    # partial install of required debian pacakges for OC-ESQL pre-compiler
    include vb_ocesql
    
    
}
