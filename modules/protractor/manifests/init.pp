class protractor(){

	$version = "v0.10.17"
	$user = "nodejs"

	$protractor_dir = ["/home/nodejs/", "/home/nodejs/.nvm/", "/home/nodejs/.nvm/${version}/", "/home/nodejs/.nvm/${version}/lib/", 
					   "/home/nodejs/.nvm/${version}/lib/node_modules/", "/home/nodejs/.nvm/${version}/lib/node_modules/protractor/", 
					   "/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example",]
	file { $protractor_dir:
		ensure => directory,
		require => File["/home/nodejs"],
	}

	file{ "/home/nodejs/protractor.sh":
		mode => '0750',
		source => "puppet:///modules/protractor/protractor.sh",
		require => File["/home/nodejs"],
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

	file {"/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example/conf.js":
                mode => 600,
                source => "puppet:///modules/protractor/conf.js",
				require => File["/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example/"],
    }

	file {"/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example/in_app.js":
        mode => 600,
        source => "puppet:///modules/protractor/in_app.js",
				require => File["/home/nodejs/.nvm/${version}/lib/node_modules/protractor/example/"],
    }
}
