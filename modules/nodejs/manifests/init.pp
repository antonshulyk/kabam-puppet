class nodejs($node_version="0.10.23") {

	sruser{nodejs: user => nodejs, }

	file { "/home/nodejs/nodeapps":
		owner => nodejs,
		group => nodejs,
		ensure => directory,
		require => Sruser['nodejs'],
	}

	file{ "/home/nodejs/cleanNodeApps.sh":
                owner => nodejs,
                group => nodejs,
                mode => '0750',
                source => "puppet:///modules/nodejs/cleanNodeApps.sh",
                require => File["/home/nodejs/nodeapps"],
        }

	file{ "/home/nodejs/deployNodeApp.sh":
		owner => nodejs,
		group => nodejs,
		mode => '0750',
		source => "puppet:///modules/nodejs/deployNodeApp.sh",
		require => File["/home/nodejs/nodeapps"],
	}

	file{ "/home/nodejs/startNodeApp.sh":
                owner => nodejs,
                group => nodejs,
                mode => '0750',
                source => "puppet:///modules/nodejs/startNodeApp.sh",
                require => File["/home/nodejs/nodeapps"],
        }

	file{ "/home/nodejs/startPm2NodeApp.sh":
                owner => nodejs,
                group => nodejs,
                mode => '0750',
                source => "puppet:///modules/nodejs/startPm2NodeApp.sh",
                require => File["/home/nodejs/nodeapps"],
        }

	file{ "/home/nodejs/stopPm2NodeApp.sh":
                owner => nodejs,
                group => nodejs,
                mode => '0750',
                source => "puppet:///modules/nodejs/stopPm2NodeApp.sh",
                require => File["/home/nodejs/nodeapps"],
        }

	file{ "/home/nodejs/restartPm2NodeApp.sh":
                owner => nodejs,
                group => nodejs,
                mode => '0750',
                source => "puppet:///modules/nodejs/restartPm2NodeApp.sh",
                require => File["/home/nodejs/nodeapps"],
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
	#########Git should be present in the system########################
	exec { "install_nvm":
		user      => nodejs,
		command   => "curl https://raw.github.com/creationix/nvm/master/install.sh | sh",
		cwd       => "/home/nodejs/",
		logoutput => true,
		require => Sruser['nodejs'],
		environment => [ "HOME=/home/nodejs" ],
	}
	
	exec { "install_nodejs":
                user      => nodejs,
		command   => "bash -c 'source .profile;nvm install ${node_version}'",
		path => '/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin',
                cwd       => "/home/nodejs/",
                logoutput => true,
                require => [ Sruser['nodejs'], Exec['install_nvm']],
                environment => [ "HOME=/home/nodejs" ],
        }
}
