#
# Manage fail2ban
#
class le_fail2ban::service {

    service { "fail2ban-server":
        enable => true,
        ensure => running,
        require => Package[fail2ban],
    }
    
}