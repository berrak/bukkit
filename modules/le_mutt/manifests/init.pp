##
## Class to manage mutt Mail User Agent (mua).
##
class le_mutt {

    include le_mutt::params
    
    package { "mutt" : ensure => present }

}