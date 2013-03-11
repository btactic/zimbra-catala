#!/bin/bash
if [ $(whoami) = "root" ]; then
	echo -e -n "\n \n \n EXECUTING SCRIPT \n \n \n"	

	NATIVE2ASCII="/opt/zimbra/java/bin/native2ascii"
	DESTDIR="/opt/zimbra/jetty/webapps/zimbra/WEB-INF/classes/messages"
	DESTDIRADMIN="/opt/zimbra/jetty/webapps/zimbraAdmin/WEB-INF/classes/messages"

	if [ -d $DESTDIR ] && [ -d $DESTDIRADMIN ]; then
		echo -e -n "\t Checking directories  \n \t \t ${DESTDIR} \n \t \t ${DESTDIRADMIN} \n \t [OK!] \n"
		echo -e -n "\t Starting backups \n"

		NOW=$(date +"%Y_%m_%d_%H_%M")
		
		mkdir backup-${NOW}
		mkdir backup-${NOW}/zimbra
		mkdir backup-${NOW}/zimbraAdmin

		cp ${DESTDIR}/*_ca.properties backup-${NOW}/zimbra
		cp ${DESTDIRADMIN}/*_ca.properties backup-${NOW}/zimbraAdmin

		echo -e -n "\t Completed backups! \n"
		echo -e -n "\t Encoding new files \n"

		TRANSLATION_FILES="AjxMsg I18nMsg ZabMsg ZbMsg ZmMsg ZmSMS ZaMsg ZhMsg ZMsg" 

		for n_prefix in ${TRANSLATION_FILES} ; do 

			$NATIVE2ASCII -encoding UTF-8 ${n_prefix}.properties ${n_prefix}_ca.properties 
		
		done 

		echo -e -n "\t Encoding complete \n"
		echo -e -n "\t Copying new files \n"
			cp -a *_ca.properties ${DESTDIR}/
			cp -a *_ca.properties ${DESTDIRADMIN}/
			chown zimbra:zimbra ${DESTDIR}/*_ca.properties
			chown zimbra:zimbra ${DESTDIRADMIN}/*_ca.properties
		echo -e -n "\t Copy done \n"
		else 
			echo -e -n " \n Directory  ${DESTDIR} \n  OR  \n  ${DESTDIRADMIN}  \n Do not exists \n"
	fi
	echo -e -n "\n  SCRIPT DONE \n \n \n"	 
else
	echo -e -n " \n You must be user 'root' to run this script \n"
	exit 1
fi
