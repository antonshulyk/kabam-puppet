define base_redis($server = "64",) {

	file {["/etc/redis", "/var/redis"]:
		ensure => directory,
	}


	file { "/usr/local/bin/redis-server":
		source  => "puppet:///modules/base_redis/${server}/redis-server",
		mode => 0754,
	}

	file { "/usr/local/bin/redis-cli":
                source  => "puppet:///modules/base_redis/${server}/redis-cli",
                mode => 0754,
        }
}
