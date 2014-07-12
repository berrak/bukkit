#
# Define new Apache2 module and load it
#
# Sample usage:
#
#     vb_apache2::module { 'mod-security' : } 
#
define vb_apache2::module {
 
    include vb_apache2
    
	case $name {
	
		'mod-security': {
	
			# Install required Debian packages
			package { [ "libxml2", "libxml2-dev","libxml2-utils"] :
				ensure => installed,
				require => Package["apache2-mpm-prefork"],
			}
			
			package { [ "libaprutil1", "libaprutil1-dev"] :
				ensure => installed,
				require => Package["apache2-mpm-prefork"],
			}
		
			# Install mod-security and rule set
			package { [ "libapache-mod-security", "modsecurity-crs"] :
				ensure => installed,
				require => Package["apache2-mpm-prefork"],
			}
			
			# Copy our configuration file with rules for mod-security
			file { "/etc/modsecurity/modsecurity.conf":
				source => "puppet:///modules/vb_apache2/modsecurity.conf",    
				owner => 'root',
				group => 'root',
				mode => '0644',
				require => Package["modsecurity-crs"],
			}   	
			
			# Create private temp directory, writable for apache (www-data)
			file { "/var/temp/${name}" :
				ensure => "directory",
				owner => $name,
				group => 'root',
				mode => '0770',
				require => File["/etc/${name}/modsecurity.conf"],
			}		
			
			# Only enable if not already enabling symlink exist,
			# if so restart apache to include new module
			exec { "Exec_enable_$name":
				command => "/usr/sbin/a2enmod $name >> /dev/null",		
				path   => "/usr/bin:/usr/sbin:/bin",
				unless => "test -e /etc/apache2/mods-enabled/$name.load",
				require => File["/etc/${name}/modsecurity.conf"],
				notify => Service["apache2"],
			}			
			
		}
		
		'headers': {
		
			# Only enable if not already enabling symlink exist,
			# if so restart apache to include new module
			exec { "Exec_enable_$name":
			    command => "/usr/sbin/a2enmod $name >> /dev/null",		
			    path   => "/usr/bin:/usr/sbin:/bin",
			    unless => "test -e /etc/apache2/mods-enabled/$name.load",
			    require => Package["apache2-mpm-prefork"],
			    notify => Service["apache2"],
			}
		}
			
		'default': {	
			fail("FAIL: Not yet defined process for Apache module ($name)")
		}
		
	}

}