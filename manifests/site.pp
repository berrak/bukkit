#
# site.pp
#
node 'kronlund01.levonline.com' {
    
    include puppetize
        
    class { admin_hosts::config :
         puppetserver_hostname => 'kronlund01'
    }
    
}
