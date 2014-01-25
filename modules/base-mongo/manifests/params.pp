class base-mongo::params {
	case $operatingsystem {
		/(Ubuntu|Debian)/: {
			$server_pkg_name = 'mongodb-10gen'
			$sources_list_file = '/etc/apt/sources.list.d/10gen.list'
			$sources_list_file_content = 'mongo_debian.repo'
		}
		/(RedHat|CentOS|Fedora)/: {
			$server_pkg_name = 'mongo-10gen-server'
			$sources_list_file = '/etc/yum.repos.d/10gen.repo'
			$sources_list_file_content = 'mongo.repo'
		}
	}
}

