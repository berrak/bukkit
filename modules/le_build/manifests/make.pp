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
	
	
	# target install directories in production system
	
	$cgiinstallpath = $::le_build::params::cgiinstallpath
	$libinstallpath = $::le_build::params::libinstallpath	
	$htmlinstallpath = $::le_build::params::htmlinstallpath	
	

	## install subdirectory makefiles
	
	if $name == $sourcename {
	
		
		file { "/home/${username}/${projectname}/${sourcename}/makefile":
			content =>  template("le_build/makefile.${name}.erb"),  
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
		}
				
		
	}
		
	if $name == $libraryname {
	
		
		file { "/home/${username}/${projectname}/$libraryname/makefile":
			content =>  template("le_build/makefile.${name}.erb"),  
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
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