##
## Install logwatch
##
class le_logwatch::install {

    package { "logwatch": ensure => installed }
    
}