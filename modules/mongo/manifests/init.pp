define mongo( $port, $hostName, $replSet, $master, $master_port, $masterHostName) {

	$mongo_data_dir="/data/mongo/${replSet}_${port}"

	$public_ip = $::ipaddress

	file { "${mongo_data_dir}":
		owner => mongo,
		group => mongo,
		ensure => directory,
		recurse => true,
	}

	file { "mongo_conf_${master}_${port}":
		name => 'mongod.conf',
		content => template('mongo/mongod_tempalte.conf'),
		path   => "${mongo_data_dir}/mongod.conf",
		owner => mongo,
		group => mongo,
		require => File["${mongo_data_dir}"],
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

	file { "${mongo_data_dir}/restart_mongo.sh":
		source => "puppet:///modules/mongo/restart_mongo.sh",
		mode    => '755',
		owner => mongo,
		group => mongo,
		require => File["mongo_conf_${master}_${port}"],
	}

	exec { "${mongo_data_dir}_restart_mongo":
		user      => mongo,
		command   => "${mongo_data_dir}/restart_mongo.sh ${mongo_data_dir}",
		logoutput => true,
		before => File["replicaset_file_${master}_${port}"],
	}

	$replicaset_file = "${master}" ? {
		master     => 'mongo/master_replicaset.cmd',
		slave => 'mongo/slave_replicaset.cmd',
	}

	file { "replicaset_file_${master}_${port}":
		content => template("${replicaset_file}"),
		path    => "${mongo_data_dir}/replicaset.cmd", 
		owner => mongo,
		group => mongo,
	}


	exec { "replicaset_${master}_${port}":
		user      => mongo,
		command => "mongo ${masterHostName}:${master_port} < ${mongo_data_dir}/replicaset.cmd",
		logoutput => true,
		require => File["replicaset_file_${master}_${port}"],
	}

	exec { "sleep_${master}_${port}":
		user => mongo,
		command => "/bin/sleep 20",
		logoutput => true,
		require => Exec["replicaset_${master}_${port}"],
	}
}
