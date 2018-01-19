#!/bin/bash
FILE="whoiSes.txt"
for SITE in $(cat sites.csv;); do 
	echo "==== ${SITE} ====" >> ${FILE};
	if [[ "${SITE} == *.br*" ]]; then 
		whois ${SITE} | egrep '(owner|person|e-mail)' >> ${FILE};
	else 
		whois ${SITE} | egrep 'Admin\ (Name|Phone|Email)' >> ${FILE};
	fi
	echo "=================" >> ${FILE};
done
