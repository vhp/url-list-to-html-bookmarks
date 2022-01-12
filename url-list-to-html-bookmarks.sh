#!/bin/bash
# Take a filename as a command line arg. File consists of lines of urls.
# Running yields a generic html bookmark file. Capable of
# being imported to your browser and beyond.
#
# Made to convert exported youtube likes to file importable to pinboard.in
#
INPUT="$1"

if [ $# -ne 1 ]; then
  echo "usage: $0 <filename>"
  exit 1
fi

if ! [ -x "$(command -v youtube-dl)" ]; then
  echo 'Error: youtube-dl is not installed.' >&2
  exit 2
fi

echo "<DL><p>"
echo -e "\t<DL><p>"

while read -r url; do
  t=$(youtube-dl -s --get-title "$url" 2>/dev/null)
  if [ $? -eq 0 ]; then
    echo -e "\t<DT><A HREF=$url>$t</A>"
  else
    echo "Error @ url:  $url" > "errors_from_$1"
  fi
  unset t
done < "$INPUT"
echo -e "\t</DL><p>"
echo "</DL>"
