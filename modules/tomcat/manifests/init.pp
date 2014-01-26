define tomcat($user, $tomcat_location, $listening_port, $shutdown_port, $version = "7.0.40", $base_tomcat = "/usr/local"){  

	file { "${base_tomcat}/${tomcat_location}":
		source  => "puppet:///modules/tomcat/apache-tomcat-${version}",
		recurse => true,
		owner => "${user}",
		group => "${user}",
		ensure => [ ['directory'] , ['present']],
		mode => '0750',
	}

	file { "/var/log/${user}/${tomcat_location}":
                ensure => directory,
                owner => "${user}",
                group => "${user}",
                mode => '0755',
        }
	
	file { "${base_tomcat}/${tomcat_location}/conf/server.xml" :
                     ensure  => present,
                     content => template("tomcat/server.xml.erb"),
                     require =>  File["${base_tomcat}/${tomcat_location}"],
                     mode => '0750',
                     owner =>"${user}",
                     group =>"${user}",
        }

	file { "${base_tomcat}/${tomcat_location}/webapps" :
                ensure => [ ['directory'] , ['present']],
                require =>  File["${base_tomcat}/${tomcat_location}"],
                mode => '0750',
                owner =>"${user}",
                group =>"${user}",
        }
}

