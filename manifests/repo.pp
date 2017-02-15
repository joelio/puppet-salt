# == Class: salt::repo
#
#  If enabled, this will install the repository used for installing salt
#
#  Please note:
#  There is no need for calling this class manually. It will be called
#  via another class
#
# === Parameters
#
# [*manage_repo*]
#   When true, it will create repository for installing salt stack 
#
# [*salt_version*]
#   This is the salt version.
#
class salt::repo (
    $manage_repo = $salt::params::manage_repo,
) inherits salt::params {
    if ($manage_repo) {
        case $osfamily {
               'Debian' : {
                   include ::apt
                   apt::source { 'saltstack':
                       location =>  "http://repo.saltstack.com/apt/ubuntu/$operatingsystemrelease/amd64/latest",
                       repos    =>  'main',
                       key      => {
                           'id' =>  '754A1A7AE731F165D5E6D4BD0E08A149DE57BFBE',
                           'source' => "https://repo.saltstack.com/apt/ubuntu/$operatingsystemrelease/amd64/latest/SALTSTACK-GPG-KEY.pub",
                       },
                       include => {
                           'src' => false,
                       }
                   }
               }
        }
    }
}
