#!/bin/sh

# temporary script i am using for reorganizing and removing the service.d folder

dir='syslog-ng.conf.d/service.d/'
for service in `ls $dir`; do
	f="${dir}/${service}"
	comment=`head -1 $f`
	name=`echo $comment | head -1 | sed -e 's/# //' -e 's/ daemon configuration$//' -e 's/ configuration$//'`
	filter=`head -3 $f | tail -1`
	destination=`head -5 $f | tail -1`
	log=`tail -1 $f`

	echo "#" $name "filter" > $dir/../filter.d/$service
	echo >> $dir/../filter.d/$service
	echo $filter >> $dir/../filter.d/$service

	echo "#" $name "destination" > $dir/../destination.d/$service
	echo >> $dir/../destination.d/$service
	echo $destination >> $dir/../destination.d/$service

	echo "#" $name "default final file log" > $dir/../log.d/90_$service
	echo >> $dir/../log.d/90_$service
	echo $log >> $dir/../log.d/90_$service
done
