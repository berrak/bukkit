##
## Puppet service.
##
class puppetize::service {

    include puppetize::params


    # Reloads puppet agent. Debian default (/etc/default/puppet) ensures
    # agent is NOT running. If this is not wanted, configure that file.
    # and change 'ensure' below with 'ensure => running'
    
    service { "halt_puppet_agent":
                  name => puppet,
	    hasrestart => true,
                enable => false,
                ensure => stopped,
	       require => Class["puppetize::install"],
    }

    # For the puppet server only
	
    if $::fqdn == $::puppetize::params::mypuppetserver_fqdn {

        service { "puppetmaster":
	    hasrestart => true,
                enable => true,
                ensure => running,
               require => Class["puppetize::install"],
        }
    
    } 

}