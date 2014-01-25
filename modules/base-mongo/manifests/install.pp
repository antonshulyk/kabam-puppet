class base-mongo::install {

	
	file { "$base-mongo::params::sources_list_file":
                source => "puppet:///modules/base-mongo/$base-mongo::params::sources_list_file_content",
        }
      Exec {
               path => [
                       '/usr/local/bin',
                       '/opt/local/bin',
                       '/usr/bin',
                       '/usr/sbin',
                       '/bin',
                       '/sbin'],
                       logoutput => true,
       }
       
       exec { "update_packages":
               command => "apt-get update",
               logoutput => true,
               require => File["$base-mongo::params::sources_list_file"],
       }

	#Sometime you have to execute the command sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10  to add key	
	package { 'mongodb':
		name => "$base-mongo::params::server_pkg_name",
		ensure => present,
		require => Exec["update_packages"],
	}

}

