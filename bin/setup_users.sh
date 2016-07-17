#!/usr/bin/env bash

IP_ADDRESS=$(ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

    echo -n "Waiting for riak to start so we can create the acceptance test users/groups ."
    until curl -m 1 -s "http://${IP_ADDRESS}:8098/ping" | grep "OK" > /dev/null 2>&1;
    do
      echo -n "."
      sleep 3
    done

echo ""

echo -n "Creating acceptance test group..."
/usr/sbin/riak-admin security add-group acceptance-test
echo "Done"

echo -n "Granting the acceptance-test group permissions..."
/usr/sbin/riak-admin security grant riak_kv.get,riak_kv.put,riak_kv.delete,riak_kv.index,riak_kv.list_keys,riak_kv.list_buckets on any to acceptance-test
echo "Done"

echo -n "Adding the acceptance-tester user ..."
/usr/sbin/riak-admin security add-user acceptance-tester groups=acceptance-test password=acceptance-testing
echo "Done"

sleep infinity

