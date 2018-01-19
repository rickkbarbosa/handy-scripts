# -*- coding: utf-8 -*-
#!/usr/bin/python


from findtools.find_files import (find_files, Match)
from ID3 import *
from pymongo import MongoClient, Connection

mp3_files_pattern = Match(filetype='f', name='*.mp3')
found_files = find_files(path='/home/rickk/Music', match=mp3_files_pattern)

conn = MongoClient(host="localhost", safe=True)
music = conn.mp3tag
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
