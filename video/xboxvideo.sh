#!/bin/bash
 
#Fuente utilizada en el subtitulo, asegurarse que está instalada o utilizar otra
FONT=/usr/share/vlc/skins2/fonts/FreeSans.ttf
VIDEO_EXT=avi
NAME_FILE=/tmp/filename.tmp
SUB_FILE=/tmp/out.srt
 
obtener_subtitulo(){
  echo $1 > $NAME_FILE
  sed -i 's/'$VIDEO_EXT'/srt/g' $NAME_FILE
  SUB=`cat $NAME_FILE`
  rm $NAME_FILE
  if [ ! -e $SUB  ]; then
   echo "[Error] No se encuentra el fichero de subtitulos: " $SUB
   exit -1;
  fi;
  echo $SUB
}
 
convertirIso2Utf8(){
  iconv -f ISO-8859-1 -t UTF-8 $1 -o $SUB_FILE
  rm $1
  mv $SUB_FILE $1
}
 
rip(){
 
  local MOVIE=$1
  local SUB=`obtener_subtitulo $MOVIE`
  local OUT=$MOVIE.sub.$VIDEO_EXT
 
  convertirIso2Utf8 $SUB
 
  echo "rip "$1
  if [ -e $OUT ]; then
    rm $OUT
  fi;
  mencoder $MOVIE  -ffourcc XVID -sub $SUB -oac mp3lame -lameopts cbr:br=128 -ovc xvid -xvidencopts pass=1 -o $OUT -subcp utf-8 -font $FONT
 
}
 
case $# in
 
0)
  echo "[Error] Número incorrecto de parámetros." $0 "fichero_origen" " [fichero destino] "
  exit -1;
  ;;
1)
  echo "1: "$1
  rip $1
  ;;
*)
  for item in $*
  do
    rip $item
  done
  ;;
 
esac