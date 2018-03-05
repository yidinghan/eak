host=${eshost:-localhost}
port=${esport:-9200}
days=${esmaxdays:-15}
prefix=${esindexprefix:-apm}

urlprefix=${host}:${port}

indexes=$(curl "${urlprefix}/_cat/indices?v&h=index" | grep "^${prefix}" | sort)
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
    curl -XDELETE "${urlprefix}/${index}"
    echo "\n"
  fi
done
