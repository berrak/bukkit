#
# Define new programming project
#
# Sample usage:
#
#     le_build::make { 'src' :
#     		projectname => 'openjensen',
#		  	   username => 'jensen',
#             groupname => 'jensen',
#     } 
#
define le_build::make ( $projectname='', $username='', $groupname='') {

	if $projectname =='' {
		fail("FAIL: Missing required project name!")
	}
	
	if $username =='' {
		fail("FAIL: Missing required user name!")
	}
	
	if $groupname =='' {
		fail("FAIL: Missing required group name!")
	}
	

    include le_build::params
	
	
	## project file structure
	
    $includename = $::le_build::params::includename
    $sourcename = $::le_build::params::sourcename	
    $libraryname = $::le_build::params::libraryname
    $htmlname = $::le_build::params::htmlname
    $docname = $::le_build::params::docname
    $builddirectory = $::le_build::params::builddirectory
	
	$copybookname = $::le_build::params::copybookname
	
	# target install directories in production system
	
	$cgiinstallpath = $::le_build::params::cgiinstallpath
	$libinstallpath = $::le_build::params::libinstallpath	
	$htmlinstallpath = $::le_build::params::htmlinstallpath
	
	# help file for remote developers (runs make and make install)
	$remote_install_scriptname = $::le_build::params::remote_install_scriptname	
	
    
	# install the remote helper script
	
	file { "/home/${username}/bin/${username}_${remote_install_scriptname}":
		content =>  template("le_build/${username}_${remote_install_scriptname}.erb"),  
		  owner => $username,
		  group => $groupname,
		   mode => '0755',
		require => Class["le_build::project"],
	}


	## install subdirectory makefiles
	
	if $name == $sourcename {
	
		
		file { "/home/${username}/${projectname}/${sourcename}/makefile":
			content =>  template("le_build/makefile.${name}.erb"),  
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
		}
		
		# Files in copybook sub directory
		
		file { "/home/${username}/${projectname}/${sourcename}/${copybookname}/sqlca.cpy":
		     source => "puppet:///modules/le_build/sqlca.cpy",
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}/${sourcename}/${copybookname}"], Class["le_build::project"]],
		}		
		
		# symlink sqlca.cbl --> sqlca.cpy (library OCESQL requires the extension 'cbl')
		
		file { "/home/${username}/${projectname}/${sourcename}/${copybookname}/sqlca.cbl":
		  ensure => link,
		   owner => $username,
		   group => $groupname,
		  target => "/home/${username}/${projectname}/${sourcename}/${copybookname}/sqlca.cpy",
		  require => File["/home/${username}/${projectname}/${sourcename}/${copybookname}/sqlca.cpy"],
		}
		
		file { "/home/${username}/${projectname}/${sourcename}/${copybookname}/${sourcename}_setupenv_${projectname}.cpy":
		     source => "puppet:///modules/le_build/${sourcename}_setupenv_${projectname}.cpy",
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}/${sourcename}/${copybookname}"], Class["le_build::project"]],
		}				
				
		
	}
		
	if $name == $libraryname {
	
		
		file { "/home/${username}/${projectname}/$libraryname/makefile":
			content =>  template("le_build/makefile.${name}.erb"),  
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
		}
		
		# Files in copybook sub directory
		
		# rename 'cbl' copybook to standard 'cpy' extension (library OCESQL requires extension cbl though)
		
		file { "/home/${username}/${projectname}/${libraryname}/${copybookname}/sqlca.cpy":
		     source => "puppet:///modules/le_build/sqlca.cpy",
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}/${libraryname}/${copybookname}"], Class["le_build::project"]],
		}				
		
		# symlink sqlca.cbl --> sqlca.cpy (library OCESQL requires the extension 'cbl')
		
		file { "/home/${username}/${projectname}/${libraryname}/${copybookname}/sqlca.cbl":
		  ensure => link,
		   owner => $username,
		   group => $groupname,
		  target => "/home/${username}/${projectname}/${libraryname}/${copybookname}/sqlca.cpy",
		  require => File["/home/${username}/${projectname}/${libraryname}/${copybookname}/sqlca.cpy"],		  
		}
		
		file { "/home/${username}/${projectname}/${libraryname}/${copybookname}/${libraryname}_setupenv_${projectname}.cpy":
		     source => "puppet:///modules/le_build/${libraryname}_setupenv_${projectname}.cpy",
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}/${libraryname}/${copybookname}"], Class["le_build::project"]],
		}				
		
		
	}		
		
		
		
	if $name == $htmlname {
		
		file { "/home/${username}/${projectname}/${htmlname}/makefile":
			content =>  template("le_build/makefile.${name}.erb"),  
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
		}
		
	}
 
    
}