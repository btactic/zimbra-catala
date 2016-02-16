#!/bin/bash
if [ $(whoami) = "root" ]; then
	echo -e -n "\n \n \n EXECUTING SCRIPT \n \n \n"

	NATIVE2ASCII="/opt/zimbra/java/bin/native2ascii"
	DESTDIR="/opt/zimbra/jetty-distribution-*/webapps/zimbra/WEB-INF/classes/messages"
	DESTDIRADMIN="/opt/zimbra/jetty-distribution-*/webapps/zimbraAdmin/WEB-INF/classes/messages"
	DESTDIRKEYS="/opt/zimbra/jetty-distribution-*/webapps/zimbra/WEB-INF/classes/keys"
	DESTDIRADMINKEYS="/opt/zimbra/jetty-distribution-*/webapps/zimbraAdmin/WEB-INF/classes/keys"
	MSGSDIR="/opt/zimbra/conf/msgs/"
	if [ -d $DESTDIR ] && [ -d $DESTDIRADMIN ] && [ -d $DESTDIRADMINKEYS ] && [ -d $DESTDIRKEYS ] && [ -d $MSGSDIR ]; then
		echo -e -n "\t Checking directories  \n \t \t ${DESTDIR} \n \t \t ${DESTDIRADMIN} \n \t [OK!] \n"
		echo -e -n "\t Starting backups \n"

		NOW=$(date +"%Y_%m_%d_%H_%M")

		mkdir backup-${NOW}
		mkdir backup-${NOW}/zimbra
		mkdir backup-${NOW}/zimbraAdmin

		cp ${DESTDIR}/*_ca.properties backup-${NOW}/zimbra
		cp ${DESTDIRADMIN}/*_ca.properties backup-${NOW}/zimbraAdmin
		cp ${DESTDIRKEYS}/*_ca.properties backup-${NOW}/zimbra
		cp ${DESTDIRADMINKEYS}/*_ca.properties backup-${NOW}/zimbraAdmin
		cp ${MSGSDIR}/*_ca.properties backup-${NOW}/zimbra

		echo -e -n "\t Completed backups! \n"

		echo -e -n "\t Encoding new files \n"

		find . -name *[^ca].properties | while read file; do

			$NATIVE2ASCII -encoding UTF-8 $file ${file/.properties/_ca.properties}

		done
		echo -e -n "\t Encoding complete \n"
		echo -e -n "\t Copying new files \n"
			cp -a message/*_ca.properties ${DESTDIR}/
			cp -a message/*_ca.properties ${DESTDIRADMIN}/
			cp -a keys/*_ca.properties ${DESTDIRKEYS}/
			cp -a keys/*_ca.properties ${DESTDIRADMINKEYS}/
			cp -a msgs/*_ca.properties ${MSGSDIR}/

			chown zimbra:zimbra ${DESTDIR}/*ca.properties
			chown zimbra:zimbra ${DESTDIRADMIN}/*ca.properties
			chown zimbra:zimbra ${DESTDIRKEYS}/*ca.properties
			chown zimbra:zimbra ${DESTDIRADMINKEYS}/*ca.properties
			chown zimbra:zimbra ${MSGSDIR}/*ca.properties

		echo -e -n "\t Copy done \n"

	else
		echo -e -n " \n Directory  ${DESTDIR} \n OR \n ${DESTDIRADMIN} \n OR \n ${DESTDIRKEYS} \n OR \n ${DESTDIRADMINKEYS} \n OR \n ${MSGSDIR} \n Do not exists \n"
	fi
	echo -e -n "\n  SCRIPT DONE \n \n \n"
else
	echo -e -n " \n You must be user 'root' to run this script \n"
	exit 1
fi
