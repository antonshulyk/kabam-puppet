define sr_redis($port = 6379, $master = "master", $master_port = 6379, $master_host = "localhost") {

	$redis_conf_file = "${master}" ? {
		master => 'sr_redis/redis.master.conf',
		slave => 'sr_redis/redis.slave.conf',
	}

	file {"/etc/redis/${port}.conf":
		ensure => present,
		content => template("${redis_conf_file}"),
	}

	file {"/etc/init.d/redis_${port}":
                ensure => present,
                content => template('sr_redis/redis_init_script'),
		mode => 0755,
        }

	file {"/var/redis/${port}":
		ensure => directory,
	}
}
