#
# Manage fail2ban
#
class le_iptables::service {

    service { "fail2ban":
        enable => true,
        ensure => running,
        require => Package[fail2ban],
    }
    
}