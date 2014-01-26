define nodeapp_monit( $app_name, $app_ip="localhost" , $app_port="80") {

	###########Make sure monit is installed
	file { "/etc/monit/conf.d/${app_name}.monit":
		content => template("nodeapp_monit/monit_conf.erb.xml"),
		mode => 0644,
	}
}
