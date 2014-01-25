class monit() {
	package { 'monit':
		ensure => present,
	}

	file { "/etc/monit/monitrc":
                source => "puppet:///modules/monit/monitrc",
		require => Package['monit'],
		mode => 0600,
        }
	
}
