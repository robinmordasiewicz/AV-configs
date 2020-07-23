#!/bin/bash
#

NAME=$1
TITLE=$2

OFFSET=100
LEFTMARGIN=46
RIGHTMARGIN=60

LEFTNAMEOFFSET=$(( ${OFFSET} + ${LEFTMARGIN} ))

NAMEWIDTH=`convert -debug annotate xc: -density 75 -gravity Northwest -strokewidth 0 -kerning .9 -units pixelspercentimeter -font ./fonts/NeusaNextCondensedBold.otf -pointsize 48 -annotate 0 "${NAME}" null: 2>&1 | grep 'Metrics:' | grep -o "width:\s[0-9]\+\.\?[0-9]\?*" | cut -f 2 -d " "`

TITLEWIDTH=`convert -debug annotate xc: -density 75 -gravity Northwest -strokewidth 1 -kerning 1.8 -units pixelspercentimeter -font ./fonts/NeusaNextCondensed.otf -pointsize 30 -annotate 0 "${TITLE}" null: 2>&1 | grep 'Metrics:' | grep -o "width:\s[0-9]\+\.\?[0-9]\?*" | cut -f 2 -d " "`

NAMEWIDTH=`echo "($NAMEWIDTH+1)/1" | bc`
TITLEWIDTH=`echo "($TITLEWIDTH+1)/1" | bc`

if [ ${NAMEWIDTH} -gt ${TITLEWIDTH} ]
then
    TEXTWIDTH=${NAMEWIDTH}
else
    TEXTWIDTH=${TITLEWIDTH}
fi

WIDTH=$(( ${OFFSET} + ${LEFTMARGIN} + ${TEXTWIDTH} + ${RIGHTMARGIN} ))
RIGHTWIDTH=$(( 1920 - ${WIDTH} ))
RIGHTNAMEOFFSET=$(( ${RIGHTWIDTH} + ${LEFTMARGIN} ))

convert  -size 1920x1080 \
    xc:none \
    -density 75 \
    -gravity Northwest \
    -units pixelspercentimeter \
    -fill "rgba( 191, 200, 205 , .7 )" \
    -draw "rectangle ${WIDTH},980 ${OFFSET},790" \
    -fill "rgba( 70, 72, 76 , .7 )" \
    -stroke "rgba( 70, 72, 76 , .0 )" \
    -strokewidth 0 \
    -kerning .9 \
    -pointsize 48 \
    -font "/home/pi/fonts/NeusaNextCondensedBold.otf" \
    -annotate +${LEFTNAMEOFFSET}+820 "${NAME}" \
    -fill "rgba( 70, 72, 76 , .7 )" \
    -stroke "rgba( 70, 72, 76 , .1 )" \
    -strokewidth 1 \
    -kerning 1.8 \
    -pointsize 30 \
    -font "/home/pi/fonts/NeusaNextCondensed.otf" \
    -annotate +${LEFTNAMEOFFSET}+881 "${TITLE}" \
PNG32:/home/pi/AV-configs/ATEM\ Media\ Pool/index0.png

convert  -size 1920x1080 \
    xc:none \
    -density 75 \
    -gravity Northwest \
    -units pixelspercentimeter \
    -fill "rgba( 191, 200, 205 , .7 )" \
    -draw "rectangle 1820,980 ${RIGHTWIDTH},790" \
    -fill "rgba( 70, 72, 76 , .7 )" \
    -stroke "rgba( 70, 72, 76 , .0 )" \
    -strokewidth 0 \
    -kerning .9 \
    -pointsize 48 \
    -font "/home/pi/fonts/NeusaNextCondensedBold.otf" \
    -annotate +${RIGHTNAMEOFFSET}+820 "${NAME}" \
    -fill "rgba( 70, 72, 76 , .7 )" \
    -stroke "rgba( 70, 72, 76 , .1 )" \
    -strokewidth 1 \
    -kerning 1.8 \
    -pointsize 30 \
    -font "/home/pi/fonts/NeusaNextCondensed.otf" \
    -annotate +${RIGHTNAMEOFFSET}+881 "${TITLE}" \
PNG32:/home/pi/AV-configs/ATEM\ Media\ Pool/index1.png

