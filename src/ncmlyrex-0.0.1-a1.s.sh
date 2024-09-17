#!/bin/bash

function Ncmlyrex_PrintUsage() {
    echo "Usage: ncmlyrex -i <song id> -o <output>"
}

while getopts ":i:o:" OPT; do
    case "$OPT" in
        i)
            Ncmlyrex_SongId="$OPTARG"
            ;;
        o)
            Ncmlyrex_Output="$OPTARG"
            ;;
        :)
            echo "$0: argument expected after \`-$OPTARG'"
            exit 1
            ;;
        *)
            Ncmlyrex_PrintUsage
            exit 1
            ;;
        ?)
            echo "$0: invalid option \`-$OPTARG'"
            exit 2
            ;;
    esac
done

if [ -f "$Ncmlyrex_Input" ]; then
    echo "$0: file exists: \`$Ncmlyrex_Output'"
    exit 1
fi

if ! curl "https://music.163.com/#/song?id=${Ncmlyrex_SongId}" > "$Ncmlyrex_Output.html"; then
    echo "$0: failed to curl \`https://music.163.com/#/song?id=${Ncmlyrex_SongId}' into \`$Ncmlyrex_Output.html'"
    exit 1
fi

cat -n $Ncmlyrex_Output.html