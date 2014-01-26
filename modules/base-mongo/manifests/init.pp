class base-mongo(){
	$public_ip = $::ipaddress
	include base-mongo::params, base-mongo::install, base-mongo::config
}
/*
class base-mongo::params {
	case $operatingsystem {
		/(Ubuntu|Debian)/: {
			$server_pkg_name = 'mongodb-10gen'
			$sources_list_file = '/etc/apt/sources.list.d/10gen.list'
			$sources_list_file_content = 'mongo_debian.repo'
		}
		/(RedHat|CentOS|Fedora)/: {
			$server_pkg_name = 'mongo-10gen-server'
			$sources_list_file = '/etc/yum.repos.d/10gen.repo'
			$sources_list_file_content = 'mongo.repo'
		}
	}
}

class base-mongo::install {

	
	file { "$base-mongo::params::sources_list_file":
                source => "puppet:///modules/base-mongo/$base-mongo::params::sources_list_file_content",
        }
	
	package { 'mongodb':
		name => "$base-mongo::params::server_pkg_name",
		ensure => present,
		require => File["$base-mongo::params::sources_list_file"],
	}

}

class base-mongo::config {

        user { 'mongo':
		ensure => present,
		managehome => false,
        }

        file { '/data':
		ensure => directory,
        }
        
        file {  ["/data/mongo", "/var/log/mongo"] :
		owner => mongo,
		group => mongo,
		ensure => directory,
		require => [ User['mongo'], File['/data'], ],
		before => Class['base-mongo::install'],
	}
}
*/
