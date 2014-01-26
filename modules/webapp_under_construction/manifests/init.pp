define webapp_under_construction($user, $folder_location,) {
	file { "$folder_location": 
		ensure => directory,
		owner => "${user}",
                group => "${user}",
		source  => "puppet:///modules/webapp_under_construction/webapp_under_construction",
		recurse => true,
	}

	file { "/home/$user/release/launchMaintenancePage.sh":
		ensure => present,
                owner => "${user}",
                group => "${user}",
		content => template("webapp_under_construction/launchMaintenancePage.sh"),
		mode => 0755,
	}
}

