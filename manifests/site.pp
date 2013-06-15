#
# site.pp
#
node 'kronlund01.levonline.com' {
    
    include puppetize
    
    include le_root_home    
        
    class { le_hosts::config : puppetserver_hostname => 'kronlund01' }
    
    class { le_iptables::config : puppetserver_hostname => 'kronlund01' }
    

    
    
}
