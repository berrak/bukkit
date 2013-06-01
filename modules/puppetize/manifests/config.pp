##
## Puppet configuration
##
class puppetize::config {

    include puppetize::params

    # sets e.g. if agent runs as daemon or not 

    file { "/etc/default/puppet" :
        ensure => present,
        source => "puppet:///modules/puppetize/puppet",
        owner => 'root',
        group => 'root',
        require => Class["puppetize::install"],
        notify => Class["puppetize::service"],
    }
    
    if $::fqdn == $::puppetize::params::mypuppetserver_fqdn {
    
        file { "/etc/puppet/puppet.conf" :
            ensure => present,
            source => "puppet:///modules/puppetize/puppet.conf",
            owner => 'root',
            group => 'root',
            require => Class["puppetize::install"],
            notify => Class["puppetize::service"],
        }
        
        file { "/etc/puppet/auth.conf" :
            ensure => present,
            source => "puppet:///modules/puppetize/auth.conf",
            owner => 'root',
            group => 'root',
            require => Class["puppetize::install"],
            notify => Class["puppetize::service"],
        }
        
        file { "/etc/puppet/fileserver.conf" :
            ensure => present,
            source => "puppet:///modules/puppetize/fileserver.conf",
            owner => 'root',
            group => 'root',
            require => Class["puppetize::install"],
            notify => Class["puppetize::service"],
        }
        
        # Utilities to run puppet manifests
        
        file { "/root/bin" :
             ensure => directory,
              owner => 'root',
              group => 'root',
               mode => '0700',
        }
        
        file { "/root/bin/puppet.exec" :
             ensure => present,
             source => "puppet:///modules/puppetize/puppet.exec",
              owner => 'root',
              group => 'root',
               mode => '0700',
            require => Class["puppetize::install"],
             notify => Class["puppetize::service"],
        }
        
        file { "/root/bin/puppet.simulate" :
             ensure => present,
             source => "puppet:///modules/puppetize/puppet.simulate",
              owner => 'root',
              group => 'root',
               mode => '0700',
            require => Class["puppetize::install"],
             notify => Class["puppetize::service"],
        }
        
        
        # sets e.g. if puppet master runs as daemon or not 
        
        file { "/etc/default/puppetmaster" :
            ensure => present,
            source => "puppet:///modules/puppetize/puppetmaster",
            owner => 'root',
            group => 'root',
            require => Class["puppetize::install"],
            notify => Class["puppetize::service"],
        }
        
    } 

}