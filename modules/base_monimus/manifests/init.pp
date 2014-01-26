class base_monimus() {
	package { 'make':
                ensure => present,
        }
	package { 'build-essential':
                ensure => present,
        }
	package { 'g++':
                ensure => present,
        }

	package { 'libicu-dev':
                ensure => present,
        }
}
