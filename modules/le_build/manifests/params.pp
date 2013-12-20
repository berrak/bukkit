##
## Parameters for make configuration
##
class le_build::params {

    # Directory structure for the project
    
	$includename = 'include'
    $libraryname = 'lib'
	$sourcename = 'src'
    $htmlname = 'html'
    $docname = 'doc'
    
    
    # before copying (installing), make puts all files here
    $builddirectory = 'build'
    
    
    ####  Target paths not yet used! ####
    
    $srcinstallpath = '/home/jensen/www.mc-butter.se/public_html/cgi-bin'
    $htmlinstallpath = '/home/jensen/www.mc-butter.se/public_html'    
    
    #####################################
    
    
    ## List of cobol source files
    
    $srclist = 'gnucobol.cbl'
    
    
    
    ## List of html files
    
    $htmllist = 'index.html'    
    
    
    

}