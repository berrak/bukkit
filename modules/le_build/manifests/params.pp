##
## Parameters for make configuration
##
class le_build::params {

    # Top directory structure for the project
    
	$includename = 'include'
    $libraryname = 'lib'
	$sourcename = 'src'
    $htmlname = 'html'
    $docname = 'doc'
    $phpname = 'php'
    
    # sub-directory below /src and /lib directories
    
    $copybookname = 'copy'
    
    
    # before copying to target host file sytem (installing)
    # 'make' copies all binaries and htmls files temporary
    
    $builddirectory = 'build'
    
    
    ##  Target paths
    
    # use same target location for html and php files    
    $htmlinstallpath = '/home/jensen/www.mc-butter.se/public_html'
    $phpinstallpath = '/home/jensen/www.mc-butter.se/public_html'        
    
    # use same target location for *.cgi and *.so files     
    $cgiinstallpath = '/home/jensen/www.mc-butter.se/public_html/cgi-bin'
    $libinstallpath = '/home/jensen/www.mc-butter.se/public_html/cgi-bin'
    
    
    ## help script to allow remote developers make and make install on server
    $remote_install_scriptname = 'remote_make_makeinstall'
 

}