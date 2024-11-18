#!/bin/bash

rmdir fish1 fish2 fish3 2>/dev/null

mkdir -p fish1 fish2 fish3

convert fish1.gif -coalesce fish1/fish1-%02d.gif
convert fish2.gif -coalesce fish2/fish2-%02d.gif
convert fish3.gif -coalesce fish3/fish3-%02d.gif

for folder in fish1 fish2 fish3; do
    for gif_file in "$folder"/*.gif; do
        filename="${gif_file%.*}"
        convert "$gif_file" -background black -alpha remove -alpha off "${filename}.ppm"
        echo "Converted $gif_file to ${filename}.ppm"
    done
done

gcc -o ppm2mem.out ppm2mem.c
if [ $? -eq 0 ]; then
    ./ppm2mem.out seabed.ppm \
        fish1/fish1-00.ppm fish1/fish1-01.ppm fish1/fish1-02.ppm fish1/fish1-03.ppm \
        fish1/fish1-04.ppm fish1/fish1-05.ppm fish1/fish1-06.ppm fish1/fish1-07.ppm \
        fish2/fish2-00.ppm fish2/fish2-01.ppm fish2/fish2-02.ppm fish2/fish2-03.ppm \
        fish2/fish2-04.ppm fish2/fish2-05.ppm fish2/fish2-06.ppm fish2/fish2-07.ppm \
        fish3/fish3-00.ppm fish3/fish3-01.ppm fish3/fish3-02.ppm fish3/fish3-03.ppm \
        fish3/fish3-04.ppm fish3/fish3-05.ppm fish3/fish3-06.ppm fish3/fish3-07.ppm
else
    echo "Compilation failed."
    exit 1
fi
