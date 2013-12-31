##
## Manage source build (with make)
##
##  This creates the project structure and copies the makefiles
##
##
##  class { le_build::project :
##     projectname => 'openjensen',
##		  username => 'jensen',
##       groupname => 'jensen',
##
## } 
##
class le_build::project ( $projectname='', $username='', $groupname='' ) {

    include le_build::params
	
    $includename = $::le_build::params::includename
    $sourcename = $::le_build::params::sourcename	
    $libraryname = $::le_build::params::libraryname
    $htmlname = $::le_build::params::htmlname
    $docname = $::le_build::params::docname
	
    $builddirectory = $::le_build::params::builddirectory
    $copybookname = $::le_build::params::copybookname	
	
	if $projectname =='' {
		fail("FAIL: Missing required project name!")
	}
	
	if $username =='' {
		fail("FAIL: Missing required user name!")
	}
	
	if $groupname =='' {
		fail("FAIL: Missing required group name!")
	}	

    
	## Create the project directory structure
	
	file { "/home/${username}/${projectname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,      
	}
	
	
	## System directory structure for the final host installation 
	
	
	file { "/home/${username}/${projectname}/${builddirectory}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
	file { "/home/${username}/${projectname}/${builddirectory}/cgi-bin":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File[ "/home/${username}/${projectname}/${builddirectory}"],
	}
	
	file { "/home/${username}/${projectname}/${builddirectory}/cgi-bin/lib":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File[ "/home/${username}/${projectname}/${builddirectory}/cgi-bin"],
	}	
	
	
	
	## create the individual sub source directories	
	
	# Cobol source
	
	file { "/home/${username}/${projectname}/${sourcename}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
	file { "/home/${username}/${projectname}/${sourcename}/${copybookname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}/${sourcename}"],
	}
		
		
	# Cobol sharted libraries	
		
	file { "/home/${username}/${projectname}/${libraryname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
	file { "/home/${username}/${projectname}/${libraryname}/${copybookname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}/${libraryname}"],
	}	
	
	# html directory
	
	file { "/home/${username}/${projectname}/${htmlname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
	# Other directories
	
	file { "/home/${username}/${projectname}/${includename}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}		
	

	file { "/home/${username}/${projectname}/${docname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}		
	
	
	## install the top makefile for the project
	
	file { "/home/${username}/${projectname}/makefile":
	    content =>  template('le_build/makefile.root.erb'),  
		  owner => $username,
		  group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
}