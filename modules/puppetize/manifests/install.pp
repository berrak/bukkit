##
## Manage Puppet
##
class puppetize::install {
  
    include puppetize::params
  
    # Debian defaults to install puppet-common which
    # depends on facter - but just to show both.
  
    # Install puppet agent regardless if this is the puppet server or agent
  
    package { [ "puppet", "facter" ] :
        ensure => present,
    }
	
    # install some utilities
    
    file { "/root/bin/puppet.exec":
	    source => "puppet:///modules/puppetize/puppet.exec",
	     owner => 'root',
	     group => 'root',
	      mode => '0700',
    }
    
    file { "/root/bin/puppet.simulate":
	    source => "puppet:///modules/puppetize/puppet.simulate",
	     owner => 'root',
	     group => 'root',
	      mode => '0700',
    }
	
  
    # For puppet server
    
    if $::fqdn == $::puppetize::params::mypuppetserver_fqdn {
    
	package { "puppetmaster" :
	    ensure => present,
	}
	    
    }

}