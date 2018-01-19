ls *.avi -R | while read i; do mkvmerge -o "${i%avi}mkv" "${i}" "$(basename ${i} avi;)srt"; done
