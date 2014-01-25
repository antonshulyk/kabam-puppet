define elasticsearch($version = "0.90.5",){

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

	exec { "install_elasticsearch":
		command   => "wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb;dpkg -i elasticsearch-${version}.deb",
		logoutput => true,
	}	
}
