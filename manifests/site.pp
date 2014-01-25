
################################### Monimus site server ############################
node "monimus.members.linode.com" {
	include monit
	include java
        include nodejs
        nodeapp{'monimus': app_name => "monimus", require => Class['monit'],}
}
################################### Monimus Server #################################
node "li652-29.members.linode.com" {
	#sruser{solr: user => solr, }
	#include monimus-solr
	#mongo{'monimusMaster':port => 27017, replSet => monimus,master => master, master_port => 27017, mongoHostName => "monimus.com"}
	include base-mongo
	mongo{'monimusMaster':port => 27027, replSet => monimus,master => master, master_port => 27027, mongoHostName => "monimus.com"}
	mongo{'monimusSlave1':port => 27028, replSet => monimus,master => slave, master_port => 27027, mongoHostName => "monimus.com",
	require => Mongo['monimusMaster'],}
	
#	include base_redis
#        sr_redis{'master_redis':}
#        sr_redis{'slave1_redis':
#                port => 6380,
#                master => slave,
#        }
}
####################Test dev server###########################################
##################### 32 bit machines
node "ubuntu.hsd1.nj.comcast.net", "ubuntu.localdomain", "ubuntu" {
	include java
        include monit
        include nodejs
        nodeapp{'kabam-app': app_name => "kabam-app", require => Class['monit'],}

        include base-mongo
        mongo{'monimusMaster':port => 27027, hostName => "monimus.com", replSet => monimus,master => master, master_port => 27027, masterHostName => "monimus.com", require => Class['base-mongo'],}
        mongo{'monimusSlave1':port => 27028, hostName => "monimus.com", replSet => monimus,master => slave, master_port => 27027, masterHostName => "monimus.com", require => [Mongo['monimusMaster'], Class['base-mongo']],}
	base_redis{'base-redis':
                server => "32",
        }

        sr_redis{'master_redis':}
        sr_redis{'slave1_redis':
                port => 6380,
               master => slave,
        }
        elasticsearch{'main_es':}

}
########################### 64 bit machines
node "dev1.monimus.com", "dev2.monimus.com", "dev3.monimus.com", "mohammed-to-be-filled-by-o-e-m.local", "precise32", "localhost.members.linode.com" {
	include java
	include monit
	include nodejs
	nodeapp{'kabam-app': app_name => "kabam-app", require => Class['monit'],}

	include base-mongo
        mongo{'monimusMaster':port => 27027, hostName => "monimus.com", replSet => monimus,master => master, master_port => 27027, masterHostName => "monimus.com", require => Class['base-mongo'],}
        mongo{'monimusSlave1':port => 27028, hostName => "monimus.com", replSet => monimus,master => slave, master_port => 27027, masterHostName => "monimus.com",
        require => [Mongo['monimusMaster'], Class['base-mongo']],}

        include base_redis
        sr_redis{'master_redis':}
        sr_redis{'slave1_redis':
                port => 6380,
               master => slave,
        }	
	elasticsearch{'main_es':}
}
####################Test dev server###########################################

############ Target Server ###########################
node "target.monimus.com" {
	sruser{solr: user => solr, }
	include monimus-solr
}
############ Monimus Search Server ##################
node "li643-59.members.linode.com" {
#	include monit
#        include nodejs
#	include base-mongo
#	include nodejs
#        nodeapp{'search-demo': app_name => "search-demo"}
#	nodeapp{'dataset-loader': app_name => "dataset-loader"}
#	include search-demo
	elasticsearch{'main_es': version => "0.90.10",}
}


##################Snapdeal laptop####################
node "l-technology.example.com" {
	include search-demo
}

###############Mettl laptop#####################
node "sandy.buildd" {
#	include monit
	include nodejs
#        nodeapp{'kabam-app': app_name => "kabam-app", require => Class['monit'],}
#        nodeapp{'dataset-loader': app_name => "dataset-loader"}
	elasticsearch{'es': version => "0.90.7",}

#	include base-mongo
#	mongo{'mettlMaster':port => 27027, hostName => "master.mongo.com", replSet => mettl,master => master, master_port => 27027, masterHostName => "master.mongo.com",}
#        mongo{'mettlSlave1':port => 27028, hostName => "slave.mongo.com", replSet => mettl,master => slave, master_port => 27027, masterHostName => "master.mongo.com", require => Mongo['mettlMaster']}
#	mongo{'mettlSlave2':port => 27029, replSet => mettl,master => slave, master_port => 27027, mongoHostName => "mettl.mongo.com", require => Mongo['mettlMaster']}
	base_redis{'base-redis':
		server => "32",
	}
#	sr_redis{'master_redis':}
#	sr_redis{'slave1_redis':
#		port => 6380,
#		master => slave,
#	}
}

node "ip-20-0-0-171" {
	include base-mongo
}



####################################Pre production Setup
node "li688-116.members.linode.com" {
	#### Backend Server1 Configuration
	/*
	include base-mongo
        mongo{'monimusMaster':port => 27027, hostName => "master.mongo.monimus.com", replSet => monimus,master => master, master_port => 27027, masterHostName => "master.mongo.monimus.com", require => Class['base-mongo'],}

        include base_redis
        sr_redis{'slave_redis':
		port => 6380,
		master => slave,
		master_host => "master.redis.monimus.com",	

	}
	*/

	#### Backend Server2 Configuration
	/*
        include base-mongo
	mongo{'monimusSlave1':port => 27028, hostName => "slave.mongo.monimus.com", replSet => monimus,master => slave, master_port => 27027, masterHostName => "master.mongo.monimus.com", require => [Class['base-mongo']],}
	include base_redis
	sr_redis{'master_redis':}
	*/

	#### Backend Server3 Configuration
	/*	
	elasticsearch{'main_es':}
	*/

	#### Showdme app
	/*
	include nodejs
	include monit
        nodeapp{'showdme': app_name => "showdme", require => Class['monit'],}
	*/

	#### Web engine
	/*
	include nginx
        nginx_conf{'showdme': app_name => showdme, require => Class ['nginx'], listen_port => 443, app_domain_name => "monimus.com", app_host => "monimus.com", app_port => 4000}
	*/

	#### Load Balancer
	include haproxy	
}

node "backend1.members.linode.com" {
	include java
	#### Backend Server1 Configuration
        include base-mongo
        mongo{'monimusMaster':port => 27027, hostName => "master.mongo.monimus.com", replSet => monimus,master => master, master_port => 27027, masterHostName => "master.mongo.monimus.com", require => Class['base-mongo'],}

        include base_redis
        sr_redis{'slave_redis':
                port => 6380,
                master => slave,
                master_host => "master.redis.monimus.com",

        }

	#### Backend Server3 Configuration
        elasticsearch{'main_es':}

	#### Web engine
        include nginx
        nginx_conf{'showdme': app_name => showdme, require => Class ['nginx'], listen_port => 443, app_domain_name => "backend1.monimus.com", app_host => "127.0.0.1", app_port => 4000}

	#### Showdme app
        include nodejs
        include monit
        nodeapp{'showdme': app_name => "showdme", require => Class['monit'],}

        #### Load Balancer
        include haproxy		
}

node "backend2.members.linode.com" {
	include java
	#### Backend Server2 Configuration
        include base-mongo
        mongo{'monimusSlave1':port => 27028, hostName => "slave.mongo.monimus.com", replSet => monimus,master => slave, master_port => 27027, masterHostName => "master.mongo.monimus.com", require => [Class['base-mongo']],}
        include base_redis
        sr_redis{'master_redis':}

	#### Showdme app
        include nodejs
        include monit
        nodeapp{'showdme': app_name => "showdme", require => Class['monit'],}

	#### Web engine
        include nginx
        nginx_conf{'showdme': app_name => showdme, require => Class ['nginx'], listen_port => 443, app_domain_name => "backend2.monimus.com", app_host => "127.0.0.1", app_port => 4000}

}
