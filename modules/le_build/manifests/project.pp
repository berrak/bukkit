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
    $phpname = $::le_build::params::phpname	
	
    $builddirectory = $::le_build::params::builddirectory
    $copybookname = $::le_build::params::copybookname
	
    # help file for remote developers (runs make and make install)
	$remote_install_scriptname = $::le_build::params::remote_install_scriptname	
	
	
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
	
	
	## System directory structure for the build directory structure (make install)
	
	
	file { "/home/${username}/${projectname}/${builddirectory}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
	# binaries and share libraries in the same directory sub directory /cgi-bin
	
	file { "/home/${username}/${projectname}/${builddirectory}/cgi-bin":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File[ "/home/${username}/${projectname}/${builddirectory}"],
	}
	
	# php layout requiress lots of different directories (build and in final install)
		
	file { "/home/${username}/${projectname}/${builddirectory}/assets":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File[ "/home/${username}/${projectname}/${builddirectory}"],
	}		
		
	# ../assets/css		
		
	file { "/home/${username}/${projectname}/${builddirectory}/assets/css":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File[ "/home/${username}/${projectname}/${builddirectory}/assets"],
	}		
	
	# ../assets/fonts		
		
	file { "/home/${username}/${projectname}/${builddirectory}/assets/fonts":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File[ "/home/${username}/${projectname}/${builddirectory}/assets"],
	}				
	
	# ../assets/img		
		
	file { "/home/${username}/${projectname}/${builddirectory}/assets/img":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File[ "/home/${username}/${projectname}/${builddirectory}/assets"],
	}	
	
	# ../assets/js		
		
	file { "/home/${username}/${projectname}/${builddirectory}/assets/js":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File[ "/home/${username}/${projectname}/${builddirectory}/assets"],
	}	
	
	## create the individual sub source directories	
	
	# Cobol source
	
	file { "/home/${username}/${projectname}/${sourcename}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
		
	# Cobol sharted libraries	
		
	file { "/home/${username}/${projectname}/${libraryname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
	# Copybook directory
	
	file { "/home/${username}/${projectname}/${copybookname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
    file { "/home/${username}/${projectname}/${copybookname}/sqlca.cpy":
		source => "puppet:///modules/le_build/sqlca.cpy",
		 owner => $username,
		 group => $groupname,
	   require => File["/home/${username}/${projectname}/${copybookname}"],
    }		
		
	# symlink sqlca.cbl --> sqlca.cpy (library OCESQL requires the extension 'cbl')
	
	file { "/home/${username}/${projectname}/${copybookname}/sqlca.cbl":
	  ensure => link,
	   owner => $username,
	   group => $groupname,
	  target => "/home/${username}/${projectname}/${copybookname}/sqlca.cpy",
	  require => File["/home/${username}/${projectname}/${copybookname}/sqlca.cpy"],
	}
		
	# html directory
	
	file { "/home/${username}/${projectname}/${htmlname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}
	
	# PHP base source directory
	
	file { "/home/${username}/${projectname}/${phpname}":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}"],
	}	
	
	# ../assets
	
	file { "/home/${username}/${projectname}/${phpname}/assets":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}/${phpname}"],
	}	
	
	# ../assets/css
	
	file { "/home/${username}/${projectname}/${phpname}/assets/css":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}/${phpname}/assets"],
	}	
	
	# ../assets/fonts
	
	file { "/home/${username}/${projectname}/${phpname}/assets/fonts":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}/${phpname}/assets"],
	}
	
	# ../assets/img
	
	file { "/home/${username}/${projectname}/${phpname}/assets/img":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}/${phpname}/assets"],
	}		
	
	# ../assets/js
	
	file { "/home/${username}/${projectname}/${phpname}/assets/js":
		ensure => "directory",
		owner => $username,
		group => $groupname,
		require => File["/home/${username}/${projectname}/${phpname}/assets"],
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
	
	## install the remote helper script
	
	file { "/home/${username}/bin/${remote_install_scriptname}":
		content =>  template("le_build/${remote_install_scriptname}.erb"),  
		  owner => $username,
		  group => $groupname,
		   mode => '0755',
	}	
	
	
	
	
	
}