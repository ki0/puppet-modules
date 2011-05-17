# Class: vagrant::backup
#
# Backups vagrant data and logs using Example42 backup meta module (to be adapted to custom backup solutions)
# It's automatically included and used if $backup=yes
# This class permits to abstract what you want to backup from the tool and module to use for backups.
#
# Variables:
# The behaviour of this class has some defaults that can be overriden by user's variables:
# $vagrant_backup_data (true|false) : Set if you want to backup vagrant's data. Default: As defined in $backup_data
# $vagrant_backup_log (true|false) : Set if you want to backup vagrant's logs. Default: As defined in $backup_log
# $vagrant_backup_frequency (hourly|daily|weekly|monthly) : Set the frequency of your vagrant backups. Default: daily.
# $vagrant_backup_target : Define how to reach (Ip, fqdn...) this host to backup vagrant from an external server. Default: As defined in $backup_target
# 
# You can also set some site wide variables that can be overriden by the above module specific ones:
# $backup_data (true|false) : Set if you want to enable data backups site-wide. 
# $backup_log (true|false) : Set if you want to enable logs backups site-wide. 
# $backup_target : Set the ip/hostname you want to use on an external backup server to backup this host
# For the defaults of the above variables check vagrant::params
#
# Usage:
# Automatically included if $backup=yes
#
class vagrant::backup {

    include vagrant::params

    backup { "vagrant_data": 
        frequency => "${vagrant::params::backup_frequency}",
        path      => "${vagrant::params::datadir}",
        enabled   => "${vagrant::params::backup_data_enable}",
        target    => "${vagrant::params::backup_target_real}",
    }
    
    backup { "vagrant_logs": 
        frequency => "${vagrant::params::backup_frequency}",
        path      => "${vagrant::params::logdir}",
        enabled   => "${vagrant::params::backup_log_enable}",
        target    => "${vagrant::params::backup_target_real}",
    }

    # Include project specific backup class if $my_project is set
    if $my_project { include "vagrant::${my_project}::backup" }

}
