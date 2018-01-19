#!/bin/bash
HERE="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

videoconvert() {
	FILE="${1}"
	LOCATION=$(echo "$(cd "$(dirname "${FILE}")"; pwd) ")
	
	/usr/bin/mkvmerge \
	  --ui-language en_US --output "${LOCATION}/$(basename "${FILE}" .avi ).mkv" \
	    --language 0:eng '(' "${LOCATION}/${FILE}" ')' \
	    --language 0:eng '(' "${LOCATION}/$(basename "${FILE}" .avi ).srt" ')' \
	    --language 0:por '(' "${LOCATION}/$(basename "${FILE}" .avi ).pob.srt" ')' \
	    --track-order 0:0,0:1,1:0,2:0	
}

cd "${VIDEODIR}"

find . -iname "*.avi" -exec ${HERE}/videoconvert.sh {} \;