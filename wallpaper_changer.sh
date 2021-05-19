#!/bin/bash

PID=$(pgrep cinnamon-session)
#export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)



# Thank you to xhienne for the wallpaper rotation script courtesy of his issue in Stackoverflow.
# Select & display a random wallpaper from my library at /storage/media/Pictures/Background/
WP_PATH=$1;


if [ -z ${WP_PATH} ];
then
    echo "Changing wallpaper randomly..." >&2

    # Get number of files (minus 1) in wallpapers
    COUNT="$(ls -l /storage/media/Pictures/Background/* | grep -v ^d | wc -l )"
    ACTUAL_COUNT=$(($COUNT+1))
    echo "Wallpaper count: ${ACTUAL_COUNT}" >&2

    # Select random number from 0 to COUNT
    RAND=$(( ( RANDOM % $COUNT ) ))
    RAND_PLUS_ONE=$(($RAND+1))
    echo "Selecting wallpaper ${RAND_PLUS_ONE}" >&2

    # Get file path of random wallpaper
    BACKGROUNDS=/storage/media/Pictures/Background
    PNG=($BACKGROUNDS/*.png)
    JPG=($BACKGROUNDS/*.jpg)
    WALLPAPERS=("${PNG[@]}" "${JPG[@]}")
    WP_PATH=${WALLPAPERS[$RAND]}
    echo "Wallpaper file path: ${WP_PATH}" >&2
else
    if [ -f $WP_PATH ];
    then
	echo "Wallpaper path was provided. Using '${WP_PATH}' as the selected background image" >&2
    else
	echo "Wallpaper path was invalid. Exiting." >&2
	exit 1
    fi
fi
   
# Set wallpaper
echo "Rendering ${WP_PATH}" >&2
cmd="gsettings set org.cinnamon.desktop.background picture-uri 'file:///${WP_PATH}'" 
echo $cmd
eval $cmd #2> .matt.gsettings.log


echo "Killing existing conky processes..." >&2
pkill conky

# Thanks to Conkymatic for the awesome suggestion, similar to what I implemented before
# Name of the color palette image
COLOR_PALETTE_IMG="colorpalette.png"
COLOR_PALETTE_WIDTH="224"


CACHE_DIRECTORY=/storage/tmp

echo >&2
echo " Generating color palette based on the wallpaper colors" >&2

# Use ImageMagick to create a color palette image based on the current wallpaper
convert "${WP_PATH}" \
+dither \
-colors 16 \
-unique-colors \
-filter box \
-geometry ${COLOR_PALETTE_WIDTH} \
${CACHE_DIRECTORY}/${COLOR_PALETTE_IMG}


# GENERATE MICRO COLOR PALETTE  ---------------------------------------------------------

# We create a temporary micro version of the color palette PNG: 1px x 16px 
# so we can gather the color value using x/y coordinates

echo >&2
echo " Extracting hex color values from color palette image" >&2

MICROIMG="${CACHE_DIRECTORY}/micropalette.png"

convert ${CACHE_DIRECTORY}/${COLOR_PALETTE_IMG} \
-colors 16 \
-unique-colors \
-depth 8 \
-size 1x16 \
-geometry 16 \
	${MICROIMG}


# EXTRACT COLOR VAlUES --------------------------------------------------------------

# Although ImageMagick allows you to extract all the image colors in one action, 
# the colors are sorted alphabetically, not from dark to light as they are when
# the color palette image is created. I ended up having to extract each color value 
# based on the x/y coordinates of the micropalette image. Also, some images have
# alpha tranparencies, so we end up with 9 character hex values. We truncate all 
# color values at 7.

COLOR1=$(convert ${MICROIMG} -crop '1x1+0+0' txt:-)
# Remove newlines 
COLOR1=${COLOR1//$'\n'/}
# Extract the hex color value
COLOR1=$(echo "$COLOR1" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[1]="${COLOR1:0:7}"

COLOR2=$(convert ${MICROIMG} -crop '1x1+1+0' txt:-)
# Remove newlines 
COLOR2=${COLOR2//$'\n'/}
# Extract the hex color value
COLOR2=$(echo "$COLOR2" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[2]="${COLOR2:0:7}"

COLOR3=$(convert ${MICROIMG} -crop '1x1+2+0' txt:-)
# Remove newlines 
COLOR3=${COLOR3//$'\n'/}
# Extract the hex color value
COLOR3=$(echo "$COLOR3" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[3]="${COLOR3:0:7}"

COLOR4=$(convert ${MICROIMG} -crop '1x1+3+0' txt:-)
# Remove newlines 
COLOR4=${COLOR4//$'\n'/}
# Extract the hex color value
COLOR4=$(echo "$COLOR4" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[4]="${COLOR4:0:7}"

COLOR5=$(convert ${MICROIMG} -crop '1x1+4+0' txt:-)
# Remove newlines 
COLOR5=${COLOR5//$'\n'/}
# Extract the hex color value
COLOR5=$(echo "$COLOR5" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[5]="${COLOR5:0:7}"

COLOR6=$(convert ${MICROIMG} -crop '1x1+5+0' txt:-)
# Remove newlines 
COLOR6=${COLOR6//$'\n'/}
# Extract the hex color value
COLOR6=$(echo "$COLOR6" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[6]="${COLOR6:0:7}"

COLOR7=$(convert ${MICROIMG} -crop '1x1+6+0' txt:-)
# Remove newlines 
COLOR7=${COLOR7//$'\n'/}
# Extract the hex color value
COLOR7=$(echo "$COLOR7" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[7]="${COLOR7:0:7}"

COLOR8=$(convert ${MICROIMG} -crop '1x1+7+0' txt:-)
# Remove newlines 
COLOR8=${COLOR8//$'\n'/}
# Extract the hex color value
COLOR8=$(echo "$COLOR8" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[8]="${COLOR8:0:7}"

COLOR9=$(convert ${MICROIMG} -crop '1x1+8+0' txt:-)
# Remove newlines 
COLOR9=${COLOR9//$'\n'/}
# Extract the hex color value
COLOR9=$(echo "$COLOR9" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[9]="${COLOR9:0:7}"

COLOR10=$(convert ${MICROIMG} -crop '1x1+9+0' txt:-)
# Remove newlines 
COLOR10=${COLOR10//$'\n'/}
# Extract the hex color value
COLOR10=$(echo "$COLOR10" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[10]="${COLOR10:0:7}"

COLOR11=$(convert ${MICROIMG} -crop '1x1+10+0' txt:-)
# Remove newlines 
COLOR11=${COLOR11//$'\n'/}
# Extract the hex color value
COLOR11=$(echo "$COLOR11" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[11]="${COLOR11:0:7}"

COLOR12=$(convert ${MICROIMG} -crop '1x1+11+0' txt:-)
# Remove newlines 
COLOR12=${COLOR12//$'\n'/}
# Extract the hex color value
COLOR12=$(echo "$COLOR12" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[12]="${COLOR12:0:7}"

COLOR13=$(convert ${MICROIMG} -crop '1x1+12+0' txt:-)
# Remove newlines 
COLOR13=${COLOR13//$'\n'/}
# Extract the hex color value
COLOR13=$(echo "$COLOR13" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[13]="${COLOR13:0:7}"

COLOR14=$(convert ${MICROIMG} -crop '1x1+13+0' txt:-)
# Remove newlines 
COLOR14=${COLOR14//$'\n'/}
# Extract the hex color value
COLOR14=$(echo "$COLOR14" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[14]="${COLOR14:0:7}"

COLOR15=$(convert ${MICROIMG} -crop '1x1+14+0' txt:-)
# Remove newlines 
COLOR15=${COLOR15//$'\n'/}
# Extract the hex color value
COLOR15=$(echo "$COLOR15" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[15]="${COLOR15:0:7}"

COLOR16=$(convert ${MICROIMG} -crop '1x1+15+0' txt:-)
# Remove newlines 
COLOR16=${COLOR16//$'\n'/}
# Extract the hex color value
COLOR16=$(echo "$COLOR16" | sed 's/.*[[:space:]]\(#[a-zA-Z0-9]\+\)[[:space:]].*/\1/')
# Truncate hex value at 7 characters. 
COLARRAY[16]="${COLOR16:0:7}"

# Delete micro image
rm ${MICROIMG}

# SET COLOR VARIABLES ---------------------------------------------------------------

echo >&2
echo " Building a randomized color map" >&2

# All colors are randomly selected from a range. We can't have complete
# randomization otherwize the conky might be unreadable, so we make it
# random within an acceptable range. The full color range is from 1 to 16.

# Background color. We select from the darkest 3 colors.
RND=$(shuf -i 1-3 -n 1)
COLOR_BACKGROUND="${COLARRAY[${RND}]}"
# Border color. Colors 5-13
RND=$(shuf -i 4-6 -n 1)
COLOR_BORDER="${COLARRAY[${RND}]}"

# Weather icon color. Colors 12-16
RND=$(shuf -i 7-9 -n 1)
COLOR_3="${COLARRAY[${RND}]}"

# Horizontal rule color. Colors 5-14
RND=$(shuf -i 10-12 -n 1)
COLOR_4="${COLARRAY[${RND}]}"

# Bars normal. Colors 9-16
RND=$(shuf -i 12-14 -n 1)
COLOR_5="${COLARRAY[${RND}]}"

RND=$(shuf -i 14-16 -n 1)
COLOR_6="${COLARRAY[${RND}]}"



cat $HOME/.config/conky/conky.conf.defaults | sed -e "s/.*color1 = .*/\\tcolor1 = '${COLOR_BACKGROUND}',/" | sed -e "s/.*color2 = .*/\\tcolor2 = '${COLOR_BORDER}',/" | sed -e "s/.*color3 = .*/\\tcolor3 = '${COLOR_3}',/" | sed -e "s/.*color4 = .*/\\tcolor4 = '${COLOR_4}',/" | sed -e "s/.*color5 = .*/\\tcolor5 = '${COLOR_5}',/" | sed -e "s/.*color6 = .*/\\tcolor6 = '${COLOR_6}',/" > $HOME/.config/conky/conky.conf

cat $HOME/.config/conky/conky.ip.conf.defaults | sed -e "s/.*color1 = .*/\\tcolor1 = '${COLOR_BACKGROUND}',/" | sed -e "s/.*color2 = .*/\\tcolor2 = '${COLOR_BORDER}',/" | sed -e "s/.*color3 = .*/\\tcolor3 = '${COLOR_3}',/" | sed -e "s/.*color4 = .*/\\tcolor4 = '${COLOR_4}',/" | sed -e "s/.*color5 = .*/\\tcolor5 = '${COLOR_5}',/" | sed -e "s/.*color6 = .*/\\tcolor6 = '${COLOR_6}',/" > $HOME/.config/conky/conky.ip.conf


conky -d -c $HOME/.config/conky/conky.conf 2> ~/.conky.default
conky -d -c $HOME/.config/conky/conky.ip.conf 2> ~/.conky.ip
