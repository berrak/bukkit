#
# Manage PostgreSQL-9.1
#
class vb_postgresql::params {

    # define western Europe encoding for a new database, ISO8859-1 (LATIN) is fine for sweden
    # $database_encoding = "ENCODING='LATIN1' LC_COLLATE='sv_SE' LC_CTYPE='sv_SE' "
    
    # UTF-8 does not work well with OpenCobol ESQL library 1.0.0 or is it the LC_*
    $database_encoding = "ENCODING='UTF8' LC_COLLATE='sv_SE.utf8' LC_CTYPE='sv_SE.utf8' "
    
    # $database_encoding = "ENCODING='UTF8'"
    
    # ASCII always works for OSS Consortiums OpenCobol Embedded SQL pre-processor (OCESQL) v1.0.0
    # $database_encoding =''

}
