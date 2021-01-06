## redis 主库启动

redis.conf

    port 6379
    bind 127.0.0.1
```
.\redis-server.exe redis.conf
```

## redis 从库启动

redis6380.conf

    port 6380
    bind 127.0.0.1
    slaveof 127.0.0.1 6379

```
.\redis-server.exe redis6380.conf
```

## redis 主库启动

redis6381.conf

    port 6381
    bind 127.0.0.1
    slaveof 127.0.0.1 6379

```
.\redis-server.exe redis6381.conf
```

## redis sentinel启动

sentinel.conf

    port 26379 // 当前Sentinel服务运行的端口  
    sentinel monitor master 127.0.0.1 6379 2   
    sentinel down-after-milliseconds master 5000  
    sentinel parallel-syncs master 1  
    sentinel failover-timeout master 15000

```
.\redis-server.exe sentinel.conf --sentinel
```
## redis sentinel1启动

sentinel1.conf

    port 26380 // 当前Sentinel服务运行的端口  
    sentinel monitor master 127.0.0.1 6379 2   
    sentinel down-after-milliseconds master 5000  
    sentinel parallel-syncs master 1  
    sentinel failover-timeout master 15000

```
.\redis-server.exe sentinel1.conf --sentinel
```
## redis sentinel2启动
redis.conf

    port 26381 // 当前Sentinel服务运行的端口  
    sentinel monitor master 127.0.0.1 6379 2   
    sentinel down-after-milliseconds master 5000  
    sentinel parallel-syncs master 1  
    sentinel failover-timeout master 15000

```
.\redis-server.exe sentinel2.conf --sentinel
```
## redis 复制
主库添加key为myname，值为“liihan”

```
.\redis-cli.exe -h 127.0.0.1 -p 6379
```
```
127.0.0.1:6379> info replication
# Replication
role:master
connected_slaves:2
slave0:ip=127.0.0.1,port=6380,state=online,offset=15966,lag=0
slave1:ip=127.0.0.1,port=6381,state=online,offset=15966,lag=0
master_repl_offset:15966
repl_backlog_active:1
repl_backlog_size:1048576
repl_backlog_first_byte_offset:2
repl_backlog_histlen:15965
```
```
127.0.0.1:6379> set myname liihan
OK
127.0.0.1:6379> get myname
"liihan"
127.0.0.1:6379>
```

从库查看
```
.\redis-cli.exe -h 127.0.0.1 -p 6380
```
```
127.0.0.1:6380> info replication
# Replication
role:slave
master_host:127.0.0.1
master_port:6379
master_link_status:up
master_last_io_seconds_ago:1
master_sync_in_progress:0
slave_repl_offset:17842
slave_priority:100
slave_read_only:1
connected_slaves:0
master_repl_offset:0
repl_backlog_active:0
repl_backlog_size:1048576
repl_backlog_first_byte_offset:0
repl_backlog_histlen:0
```
```
127.0.0.1:6380> get myname
"liihan"
```

查看Sentinel
```
.\redis-cli.exe -h 127.0.0.1 -p 26379
```
```
127.0.0.1:26379> info sentinel
# Sentinel
sentinel_masters:1
sentinel_tilt:0
sentinel_running_scripts:0
sentinel_scripts_queue_length:0
sentinel_simulate_failure_flags:0
master0:name=master,status=ok,address=127.0.0.1:6379,slaves=2,sentinels=3
```