#
# Regular cron jobs for the builder package
#
0 4	* * *	root	[ -x /usr/bin/builder_maintenance ] && /usr/bin/builder_maintenance
