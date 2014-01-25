define nodeapp( $app_name) {

	#################To start app using upstart#################
	file { "/etc/init/${app_name}.conf":
		owner => root,
                group => root,
                ensure => present,
                content => template("nodeapp/nodeapp.erb.xml"),	
		mode => 0644,
	}

	file { "/var/log/${app_name}.sys.log":
                owner => root,
                group => root,
                ensure => present,
		mode => 0666,
        }
	/*
	file { "/home/nodejs/nodeapps/${app_name}":
                owner => nodejs,
                group => nodejs,
                ensure => ['directory','present'],
                mode => 0755,
        }
	*/
	
	file { "/home/nodejs/${app_name}_env.properties":
                owner => nodejs,
                group => nodejs,
               source => "puppet:///modules/nodeapp/env.properties",
                ensure => ['directory','present'],
                mode => 0755,
        }


	###########Make sure monit is installed
	file { "/etc/monit/conf.d/${app_name}.monit":
		content => template("nodeapp/monit_conf.erb.xml"),
		mode => 0644,
	}
}
