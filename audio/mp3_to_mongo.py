#!/usr/bin/python
# ===============================================================================
# IDENTIFICATION DIVISION
#        ID SVN:   $Id$
#          FILE:  mp3_to_mongo.py
#         USAGE:  ---
#   DESCRIPTION:  Find mp3 files, read your ID3tags and upload information to MongoDB collection or AWS DynamoDB Table
#       OPTIONS:  ---
#  REQUIREMENTS:  mutagen
#                 pymongo
#
#          BUGS:  ---
#         NOTES:  ---
#          TODO:  ---
#        AUTHOR:  Ricardo Barbosa (Rickk Barbosa), rbarbosa@advertiser.com.br
#       COMPANY:  ---
#       VERSION:  2.0
#       CREATED:  12/08/2014 09:58:30 AM BRT
#      REVISION:  26/05/2020 01:05:20 AM BRT
# ===============================================================================

import boto3
import pymongo
import os
from mutagen.easyid3 import EasyID3

if(sys.version_info.major >= 3):
    import importlib
    importlib.reload(sys)
else:
    reload(sys)
    sys.setdefaultencoding("utf-8")


music_path = "/root/Music"
music_collectionname = "music"
mongodb_host = "mongodb://localhost:27017/"


''' Searching for MP3 Files '''
found_files = list()
for root, directories, filenames in os.walk(music_path):
    for filename in filenames:
        if '.mp3' in filename:
            found_files.append(os.path.join(root, filename))


''' MongoDB Connect '''
conn = pymongo.MongoClient(mongodb_host)
music = conn[music_collectionname]
mp3_tags = music.tags
tags.create_index('filename')


''' Filling List '''
tags = []
for found_file in found_files:
    tagmp3 = {}
    try:
        ''' Reading tags '''
        id3info = EasyID3(found_file)
        for item in id3info.items():
            tagmp3[item[0].lower()] = item[1][0]
            ''' Filling NoSQL '''
            # mp3_tags.update({'filename':found_file},tagmp3,upsert=True)       #MongoDB
        tags.append(tagmp3)
    except Exception as e:
        print("")


''' When DynamoDB '''
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(music_collectionname)

for i in range(len(tags)):
    table.put_item(
        Item=tags[i]
    )
