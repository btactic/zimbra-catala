#!/bin/sh

NATIVE2ASCII="/opt/zimbra/jdk1.5.0_19/bin/native2ascii"
DESTDIR="/opt/zimbra/jetty/webapps/zimbra/WEB-INF/classes/messages"

$NATIVE2ASCII -encoding UTF-8 AjxMsg.properties AjxMsg_ca.properties
$NATIVE2ASCII -encoding UTF-8 ZmMsg.properties ZmMsg_ca.properties
$NATIVE2ASCII -encoding UTF-8 ZMsg.properties ZMsg_ca.properties
$NATIVE2ASCII -encoding UTF-8 I18nMsg.properties I18nMsg_ca.properties

mkdir backups
cp $DESTDIR/*_ca.properties backups/

mv *_ca.properties $DESTDIR/
