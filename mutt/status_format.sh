echo mailwidget:set_text\(\"$1\"\) | awesome-client
if [ "$1" -eq "0" ]; then
	echo mailicon:set_image\(\"$HOME/.config/awesome/themes/ducouloa/icons/mail.png\"\) | awesome-client
else
	echo mailicon:set_image\(\"$HOME/.config/awesome/themes/ducouloa/icons/mail_on.png\"\) | awesome-client
fi;

echo "-%r-Mutt: %f [Msgs:%?M?%M/?%m%?n? New:%n?%?o? Old:%o?%?d? Del:%d?%?F? Flag:%F?%?t? Tag:%t?%?p? Post:%p?%?b? Inc:%b?%?l? %l?]---(%s/%S)-%>-(%P)---%"
