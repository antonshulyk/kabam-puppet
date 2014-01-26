class nginx() {

	#########Refer this link in fase nginx.conf is not available http://askubuntu.com/questions/361902/how-to-install-nginx-after-removed-it-manually
	package { 'nginx':
		ensure => present,
	}

	file {"/etc/nginx/ssl":
		ensure => present,
		recurse => true,
		mode => 0755,
		source => "puppet:///modules/nginx/ssl",
		require => Package['nginx'],
	}

	file {"/usr/sbin/nginxdissite":
                ensure => present,
                mode => 0755,
                source => "puppet:///modules/nginx/nginxdissite",
        }

	file {"/usr/sbin/nginxensite":
                ensure => present,
                mode => 0755,
                source => "puppet:///modules/nginx/nginxensite",
        }
}
