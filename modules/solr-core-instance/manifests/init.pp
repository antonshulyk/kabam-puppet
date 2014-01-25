define solr-core-instance( $instance_name, $core_name, $master, $slave, $port, $version = 4) {
	file { "/etc/solr/${instance_name}/${core_name}/conf":
		owner => solr,
		group => solr,
		ensure => directory,
		source => "puppet:///modules/solr-core-instance/${version}/conf",
		recurse => true,
		require =>  File["/etc/solr/${instance_name}/${core_name}"]
	}
	
	file { "/etc/solr/${instance_name}/${core_name}/conf/solrcore.properties":
                owner => solr,
                group => solr,
                ensure => present,
                content => template("solr-core-instance/solrcore.properties"),
        }

	file { [ "/etc/solr/${instance_name}/${core_name}", "/etc/solr/${instance_name}/${core_name}/data" ]:
                owner => solr,
                group => solr,
                ensure => directory,
        }
}
