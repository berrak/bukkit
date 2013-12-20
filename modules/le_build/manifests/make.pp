#
# Define new Apache2 virtual hosts in var/www file system and enables it
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
	
	
	
	## source files
	
	$srclist = $::le_build::params::srclist
	$htmllist = $::le_build::params::htmllist
	

	## install subdirectory makefile's and source files
	
	if $name == $sourcename {
	
		
		file { "/home/${username}/${projectname}/${sourcename}/Makefile":
			content =>  template("le_build/Makefile.${name}.erb"),  
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
		}
		
		file { "/home/${username}/${projectname}/${sourcename}/${srclist}":
			 source => "puppet:///modules/lb_build/${srclist}",    
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
		}      			
			
		
	}
		
	if $name == $htmlname {
		
		file { "/home/${username}/${projectname}/${htmlname}/Makefile":
			content =>  template("le_build/Makefile.${name}.erb"),  
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
		}
		
		
		file { "/home/${username}/${projectname}/${htmlname}/${htmllist}":
			 source => "puppet:///modules/lb_build/${htmllist}",    
			  owner => $username,
			  group => $groupname,
			require => [ File["/home/${username}/${projectname}"], Class["le_build::project"]],
		}      					
			
		
	}
 
    
}