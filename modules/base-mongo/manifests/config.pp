class base-mongo::config {

        user { 'mongo':
		ensure => present,
		managehome => false,
        }

        
        file {  ["/data/mongo", "/var/log/mongo"] :
		owner => mongo,
		group => mongo,
		ensure => directory,
		require => [ User['mongo'] ],
		before => Class['base-mongo::install'],
	}
}
