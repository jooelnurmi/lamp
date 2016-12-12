class lamp{

	Package { ensure => "installed", allowcdrom => "true",}
		package {"apache2":}
		package {"ssh":}
		package {"php7.0":}
		package {"libapache2-mod-php":
			require => Package ["apache2"],
	}
		package {"mysql-client":}
		package {"mysql-server":}
	
		

	file {"/var/www/html/index.html":
                content => "Toimiiko\n",

	}
	
	file {"/home/xubuntu/public_html":
		ensure => "directory",
	}	

	file{"/home/xubuntu/public_html/index.php": 
		content => template("lamp/index.php"),
	}




	file{"/etc/apache2/mods-enabled/userdir.conf":
		ensure => "link",
		target => "../mods-available/userdir.conf",
		notify => Service ["apache2"],
	}

	file {"/etc/apache2/mods-enabled/userdir.load":
		ensure => "link",
		target => "../mods-available/userdir.load",
		notify => Service ["apache2"],
	}

	file {"/etc/apache2/mods-available/php7.0.conf":
		content => template("lamp/php7.0.conf"),
		notify => Service ["apache2"],
	}

	service {"apache2":
		ensure => "running",
		enable => "true",
		provider => "systemd",
	}



}
