##
## Puppet service.
##
class puppetize::service {

    include puppetize::params


    # Reloads puppet agent. Debian default (/etc/default/puppet) ensures
    # agent is NOT running. If this is not wanted, configure that file.
    # and change 'ensure' below with 'ensure => running'
    
    service { "halt_puppet_agent":
              name => "puppet",
            enable => false,
            ensure => stopped,
	   require => Class["puppetize::install"],
    }

    # For the puppet server only
	
    if $::fqdn == $::puppetize::params::mypuppetserver_fqdn {

        service { "run_puppet_master":
	      name => "puppetmaster",
            enable => true,
            ensure => running,
            require => Class["puppetize::install"],
        }
    
    } 

}