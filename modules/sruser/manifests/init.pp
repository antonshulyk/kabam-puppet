define sruser($user,){  

	user { "${user}":
		ensure     => 'present',
		home       => "/home/${user}",
		shell      => '/bin/bash',
		managehome =>  true,
	}

	
	file { "/home/${user}/release": 
		ensure => directory,
		owner => "${user}",
                group => "${user}",
	}
	

	file { "/var/log/${user}":
                ensure => directory,
                owner => "${user}",
                group => "${user}",
		mode => '0755',
        }

	file { "/home/${user}/.ssh":
		ensure => directory,
		owner => "${user}",
                group => "${user}",
                mode => '0700',
	}

	file { "/home/${user}/.ssh/authorized_keys":
                ensure => directory,
                owner => "${user}",
                group => "${user}",
                mode => '0640',
		source =>  "puppet:///sruser/authorized_keys",
		require => File["/home/${user}/.ssh"],
        }

	
	file { "/home/${user}/release/component-deploy.sh" :
		ensure => present,
                content   => template("sruser/scriptDir/component-deploy.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
	}

	file { "/home/${user}/release/component-war-deploy.sh" :
                ensure => present,
                content   => template("sruser/scriptDir/component-war-deploy.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
        }

	file { "/home/${user}/release/component-war-deploy-as-context.sh" :
                ensure => present,
                content   => template("sruser/scriptDir/component-war-deploy-as-context.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
        }
	
	file { "/home/${user}/release/component-war-deploy-with-static.sh" :
                ensure => present,
                content   => template("sruser/scriptDir/component-war-deploy-with-static.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
        }

	file { "/home/${user}/release/startServer.sh" :
                ensure => present,
                content   => template("sruser/scriptDir/startServer.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
        }

	file { "/home/${user}/release/stopServer.sh" :
                ensure => present,
                content   => template("sruser/scriptDir/stopServer.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
        }

	file { "/home/${user}/release/static-deploy.sh" :
                ensure => present,
                content   => template("sruser/scriptDir/static-deploy.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
        }

        file { "/home/${user}/release/component-war-deploy-as-root.sh" :
                ensure => present,
                content   => template("sruser/scriptDir/component-war-deploy-as-root.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
        }

	file { "/home/${user}/release/restartServer.sh" :
                ensure => present,
                content   => template("sruser/scriptDir/restartServer.sh"),
                owner => "${user}",
                group => "${user}",
                mode   =>  '0740',
        }
}

