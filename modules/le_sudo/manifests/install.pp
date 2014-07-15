##
## Class to manage user with sudo capability.
##
class le_sudo::install {

    package { "sudo" : ensure => present }

}