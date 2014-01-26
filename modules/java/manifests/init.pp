class java() {
	package { 'openjdk-7-jre':
		ensure => present,
	

}
	package { 'git-core':
                ensure => present,
        }

}
