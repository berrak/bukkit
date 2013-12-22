#
# Defines backup job by cron for project
#
# Assumes that the project is placed directly below
# user home directory ~/$projectname
#
#
# Sample usage:
#
#     le_build::backup { 'jensen' :
#     		projectname => 'openjensen',
#     } 
#
define le_build::backup ( $projectname='') {

	if $projectname =='' {
		fail("FAIL: Missing required project name!")
	}
			
	file { "/etc/cron.daily/${projectname}":
		content =>  template("le_build/cron-daily.${projectname}.erb"),
		owner => 'root',
		group => 'root',
		 mode => '0755',
		require => Class["le_build::project"],
	}
		
}