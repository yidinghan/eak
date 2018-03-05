host=${eshost:-localhost}
days=${esmaxdays:-15}
prefix=${esindexprefix:-apm}

indexes=$(curl "${host}:9200/_cat/indices?v&h=index" | grep "^${prefix}" | sort)
now=$(date "+%s")
echo "indexes": $indexes
echo "now": $now

for index in $indexes
do
  date=$(echo $index | cut -d '-' -f 3 | sed "s/\./-/g")
  datetime=$(date -d "$date" +%s)
  diff=$((((now - datetime) / 86400) - days))
  if [ $diff -gt -1 ]
  then
    echo "delete:" $index
    curl -XDELETE "${host}:9200/${index}"
    echo "\n"
  fi
done
