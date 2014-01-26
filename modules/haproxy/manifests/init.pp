class haproxy() {

	package { 'haproxy':
		ensure => present,
	}
	
	file {"/etc/default/haproxy":
                ensure => present,
                mode => 0755,
                source => "puppet:///modules/haproxy/default_harproxy",
		require => Package['haproxy'],
        }

	file {"/etc/haproxy/haproxy.cfg":
                ensure => present,
                mode => 0755,
                source => "puppet:///modules/haproxy/harproxy.cfg",
                require => Package['haproxy'],
        }
}
