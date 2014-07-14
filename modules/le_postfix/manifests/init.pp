#
# Module to manage one central postfix server mta.
# In/outgoing mail via ISP smtp host. 
#
class le_postfix {

    include le_postfix::params, le_postfix::install, le_postfix::service

}