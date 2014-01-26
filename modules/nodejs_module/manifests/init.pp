# This user defined type has dependency on nodejs module nodejs module should also be configured on the system
define nodejs_module($module, $node_version="0.10.23") {

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

	exec { "install_module_${module}":
		user      => nodejs,
		command   => "bash -c 'source .profile;nvm use ${node_version};npm install ${module} -g'",
		path => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
		cwd       => "/home/nodejs/",
		logoutput => true,
		require => Sruser['nodejs'],
		environment => [ "HOME=/home/nodejs" ],
	}
}
