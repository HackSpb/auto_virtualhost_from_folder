#!/bin/bash
#ver 1.0

email='webmaster@localhost'


DOMAINSFOLDER="/opt/lampp/www";

httpdVhosts='/opt/lampp/etc/extra/httpd-vhosts.conf'

NEWXML=""

for TNAME in ` find /opt/lampp/www -maxdepth 1 -type d ` ; do
	NAME=`basename "$TNAME"`  
	if [[ "$NAME" != "."  && "$NAME" != "www" ]]
		then 

		if ! grep -n "127\.0\.0\.1[[:space:]]*$NAME$" /etc/hosts 
		then


				if ! echo  "
	##### block add_vhosts start
	<VirtualHost 127.0.0.1:80>
		ServerName $NAME
		DocumentRoot \"$DOMAINSFOLDER/$NAME\"
		ErrorLog \"logs/$NAME-error.log\"
		LogLevel error
		CustomLog \"logs/$NAME-access.log\" combined
		<Directory \"$DOMAINSFOLDER/$NAME\"> 
        	Options Indexes FollowSymLinks Includes execCGI 
        	AllowOverride All 
         	Require all granted 
    	</Directory> 
	</VirtualHost>
	##### add_vhosts end
	" >> $httpdVhosts
				then
					echo "There is an ERROR creating $$NAME file"
					exit;
				else
						echo "New $NAME Virtual Host Created"
				fi
	
		
			if ! echo "127.0.0.1   $NAME" >> /etc/hosts
			then
				echo "ERROR: Not able to write $NAME in /etc/hosts"
				exit;
			else
				echo "Host $NAME added to /etc/hosts file"
			fi
		fi

	fi
done

