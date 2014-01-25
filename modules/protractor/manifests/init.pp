class protractor($version = "v0.10.17"){

	file{ "/home/nodejs/protractor.sh":
		owner => nodejs,
		group => nodejs,
		mode => '0750',
		source => "puppet:///modules/protractor/protractor.sh",
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
	
#	file { ["/home/nodejs/", "/home/nodejs/.nvm", "/home/nodejs/.nvm/${version}", "/home/nodejs/.nvm/${version}/lib", "/home/nodejs/.nvm/${version}/lib/node_modules", "/home/nodejs/.nvm/${version}/lib/node_modules/protractor", "/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example"]:
#		owner => 'nodejs',
#		group => 'nodejs',
#		ensure => directory,
#		require => Sruser['nodejs'],
#	}

#	file { "/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example":
#		owner => 'nodejs',
#		group => 'nodejs',
#		ensure => directory,
#		require => Sruser['nodejs'],
#	}

	file {"/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example/conf.js":
                owner => nodejs,
                group => nodejs,
                mode => 0755,
                source => "puppet:///modules/protractor/conf.js",
        }

	file {"/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example/in_app.js":
		owner => nodejs,
		group => nodejs,
        mode => 0755,
        source => "puppet:///modules/protractor/in_app.js",
        }
}
