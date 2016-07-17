FROM jjulien/riak
RUN mkdir -p /usr/local/bin/riak
ADD bin/setup_users.sh /usr/local/bin/riak/setup_users.sh
RUN mkdir /etc/service/riak_users
ADD bin/riak_users /etc/service/riak_users/run


