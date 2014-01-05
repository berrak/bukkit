##
## Install fail2ban
##
class le_fail2ban::install {

    package { "fail2ban": ensure => installed }
    
}