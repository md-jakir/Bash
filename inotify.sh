inotifywait -q -m -e close_write hello.sh |
while read -r filename event; do
  ./hello.sh         # or "./$filename"
done
