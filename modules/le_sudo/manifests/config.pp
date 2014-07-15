##
##  Sample use:
##      le_sudo::config { 'bekr': }
##
define le_sudo::config {

    include le_sudo

    exec { "Add_{$name}_To_Administrator_Group" :
            command => "usermod -a -G sudo $name",
               path => '/usr/sbin',
        refreshonly => true,
            require => Package["sudo"],
    }    
    
}