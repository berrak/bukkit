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
    
    # sub-directory below /src and /lib directories
    
    $copybookname = 'copy'
    
    
    # before copying to target host file sytem (installing)
    # 'make' copies all binaries and htmls files temporary
    
    $builddirectory = 'build'
    
    
    ##  Target paths
    
    $cgiinstallpath = '/home/jensen/www.mc-butter.se/public_html/cgi-bin'
    $htmlinstallpath = '/home/jensen/www.mc-butter.se/public_html'    

    # use same target location for *.so shared libraries 
    $libinstallpath = '/home/jensen/www.mc-butter.se/public_html/cgi-bin'     
 

}