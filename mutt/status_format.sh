#!/bin/bash
count=${1}
box=${2:1:3}

echo mailwidget:set_text\(\"${box}:${count}\"\) | awesome-client
if [ "$count" -eq "0" ]; then
	echo mailicon:set_image\(\"$HOME/.config/awesome/themes/ducouloa/icons/mail.png\"\) | awesome-client
else
	echo mailicon:set_image\(\"$HOME/.config/awesome/themes/ducouloa/icons/mail_on.png\"\) | awesome-client
fi;

echo "-%r-Mutt: %f [Msgs:%?M?%M/?%m%?n? New:%n?%?o? Old:%o?%?d? Del:%d?%?F? Flag:%F?%?t? Tag:%t?%?p? Post:%p?%?b? Inc:%b?%?l? %l?]---(%s/%S)-%>-(%P)---%"
