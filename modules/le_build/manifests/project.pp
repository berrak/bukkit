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
	
	
	## create the individual sub directories
	
	
	file { "/home/${username}/${projectname}/${builddirectory}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
	}		
	
	file { "/home/${username}/${projectname}/${includename}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
	}		
	
	file { "/home/${username}/${projectname}/${libraryname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
	}			
	
	file { "/home/${username}/${projectname}/${sourcename}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
	}			
	
	file { "/home/${username}/${projectname}/${htmlname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
	}				
	
	file { "/home/${username}/${projectname}/${docname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
	}		
	
	
	## install the top makefile's for the project
	
	file { "/home/${username}/${projectname}/Makefile":
	    content =>  template('le_build/Makefile.root.erb'),  
		  owner => $username,
		  group => $groupname,
	}
	
	

}