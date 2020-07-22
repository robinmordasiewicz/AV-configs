#!/bin/bash
#

NAME="FU BAR"
TITLE="SOLUTIONS ENGINEER"

OFFSET=100
LEFTMARGIN=46
RIGHTMARGIN=60

NAMEOFFSET=$(( ${OFFSET} + ${LEFTMARGIN} ))

NAMEWIDTH=`convert -debug annotate  xc: -density 75 -gravity Northwest -strokewidth 0 -kerning .9 -units pixelspercentimeter -font ./fonts/NeusaNextCondensedBold.otf -pointsize 48 -annotate 0 "${NAME}" null: 2>&1 | grep 'Metrics:' | grep -o "width:\s[0-9]\+\.\?[0-9]\?*" | cut -f 2 -d " "`

TITLEWIDTH=`convert -debug annotate  xc: -density 75 -gravity Northwest -strokewidth 1 -kerning 1.8 -units pixelspercentimeter -font ./fonts/NeusaNextCondensed.otf -pointsize 30 -annotate 0 "${TITLE}" null: 2>&1 | grep 'Metrics:' | grep -o "width:\s[0-9]\+\.\?[0-9]\?*" | cut -f 2 -d " "`

NAMEWIDTH=`echo "($NAMEWIDTH+1)/1" | bc`
TITLEWIDTH=`echo "($TITLEWIDTH+1)/1" | bc`

if [ ${NAMEWIDTH} -gt ${TITLEWIDTH} ]
then
    TEXTWIDTH=${NAMEWIDTH}
else
    TEXTWIDTH=${TITLEWIDTH}
fi

WIDTH=$(( ${OFFSET} + ${LEFTMARGIN} + ${TEXTWIDTH} + ${RIGHTMARGIN} ))

#    -adaptive-blur 0x2 \
convert  -size 1920x1080 \
    -alpha on \
    -channel a \
    -evaluate multiply 0.65 +channel \
    xc:none \
    -density 75 \
    -gravity Northwest \
    -units pixelspercentimeter \
    -fill "rgba( 241, 250, 255 , 0.8 )" \
    -draw "rectangle ${WIDTH},980 ${OFFSET},790" \
    -fill "#46484c" \
    -stroke "#46484c" \
    -strokewidth 0 \
    -kerning .9 \
    -pointsize 48 \
    -font "./fonts/NeusaNextCondensedBold.otf" \
    -annotate +${NAMEOFFSET}+820 "${NAME}" \
    -fill "#46484c" \
    -stroke "#46484c" \
    -strokewidth 1 \
    -kerning 1.8 \
    -pointsize 30 \
    -font "./fonts/NeusaNextCondensed.otf" \
    -annotate +${NAMEOFFSET}+881 "${TITLE}" \
PNG32:nametag.png

