host=${host:-localhost}
days=${days:-15}

datediff() {
  d1=$(date -d "$1" +%s)
  d2=$(date -d "$2" +%s)
  echo "d1:" $d1
  echo "d2:" $d2
  return $(((d1 - d2) / 86400))
}

indexes=$(curl "${host}:9200/_cat/indices?v&h=index" | grep apm | sort)
now=$(date "+%s")
echo "indexes": $indexes
echo "now": $now

for index in $indexes
do
  date=$(echo $index | cut -d '-' -f 4 | sed "s/\./-/g")
  datetime=$(date -d "$date" +%s)
  diff=$((((now - datetime) / 86400) - days))
  if [ $diff -gt -1 ]
  then
    echo "delete:" $index
  fi
done