import 'tomcat'

define solr-instance( $instance_name, $startup_port ,$shutdown_port, $version = 4) {
	file { "/etc/solr/${instance_name}":
		owner => solr,
		group => solr,
		ensure => directory,
		recurse => true,
	}

	tomcat{"${instance_name}-tomcat":
                user => solr,
                tomcat_location => "${instance_name}-tomcat",
                listening_port => "${startup_port}",
                shutdown_port => "${shutdown_port}",
        }

	file{ "/usr/local/${instance_name}-tomcat/webapps/solr":
		ensure => 'absent',
		force => true,
                require => Tomcat["${instance_name}-tomcat"],
        }

	file{ "/usr/local/${instance_name}-tomcat/webapps/solr.war":
		owner => solr,
		group => solr,
		mode => '0755',
		source => "puppet:///modules/solr-instance/solr-${version}.war",
		require => Tomcat["${instance_name}-tomcat"],
	}

	file{ "/usr/local/${instance_name}-tomcat/bin/setenv.sh":
                owner => solr,
                group => solr,
                mode => '0755',
		content => template("solr-instance/setenv.sh"),
                require => Tomcat["${instance_name}-tomcat"],
        }
}

