ls *.rmvb -R | while read i; do 
	/usr/bin/mencoder -oac mp3lame -lameopts cbr:br=64:vol=2 -srate 22050 -ovc xvid -sws 1 -xvidencopts bitrate=500:max_key_interval=120:vhq=4 -ofps 30 ${i} -o "$(basename ${i} rmvb;).avi"; 
done
