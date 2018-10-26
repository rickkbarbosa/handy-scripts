# -*- coding: utf-8 -*-
#!/usr/bin/python
#===============================================================================
# IDENTIFICATION DIVISION
#        ID SVN:   $Id$
#          FILE:  mp3_to_mongo.py
#         USAGE:  ---
#   DESCRIPTION:  Find mp3 files, read your ID3tags and upload information to MongoDB collection
#       OPTIONS:  ---
#  REQUIREMENTS:  pymongo (apt-get install python-pymongo)
#			  python-idtag (apt-get install python-id3 // yum install ftp://ftp.pbone.net/mirror/archive.fedoraproject.org/fedora/linux/releases/14/Everything/x86_64/os/Packages/python-id3-1.2-16.fc14.noarch.rpm
#                                 
#				  findtools (pip install findtools)
#          BUGS:  ---
#         NOTES:  ---
#          TODO:  ---
#        AUTHOR:  Ricardo Barbosa (Rickk Barbosa), rbarbosa@advertiser.com.br
#       COMPANY:  Advertiser Technologies
#       VERSION:  1.0
#       CREATED:  12/08/2014 09:58:30 AM BRT
#      REVISION:  ---
#===============================================================================

from findtools.find_files import (find_files, Match)
from ID3 import *
from pymongo import *

mp3_files_pattern = Match(filetype='f', name='*.mp3')
found_files = find_files(path='/root/Music', match=mp3_files_pattern)

conn = MongoClient(host="mongodbR")
music = conn.music
tags = music.tags

tags.create_index('filename')

for found_file in found_files:
        tagmp3 = {}
        id3info = ID3(found_file)
        fileName = id3info.file.name.decode('utf-8','ignore')
        for item in id3info.items():
                tagmp3[item[0].lower().decode("utf-8", "ignore")] = item[1].decode("utf-8","ignore")
        fileName = id3info.file.name.decode('utf-8','ignore')
        tagmp3['filename'] = fileName
        tags.update({'filename':fileName},tagmp3,upsert=True)
