##
## Manage rsyslog
##
class hp_rsyslog::params {

    ## log server (i.e. the receiving log host)

    $myloghost_ip = '217.70.39.231'  ## mc-butter ##
    
    # all logfiles that rsyslog writes (local or remote) here will be checked
    
    $logcheckfilespath = '/var/log/logcheck'
    
    
    ## receive logs from hosts (needed subdirectory below REMOTELOGS/)
    
    $send_host1 = 'hphome'
    $send_host2 = 'dl380g7'
    
}