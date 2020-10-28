学习笔记
## 并行GC

###1. 特点
+ 新生代收集器
+ 采用复制算法
+ 多线程收集
###2. 设置参数
+ "-XX:MaxGCPauseMillis"
    + 控制最大垃圾收集停顿时间，MaxCGPauseMillis 设置的稍微小一点，停顿时间会缩短，但也有可能导致吞吐量下降。因为可能导致垃圾收集器发生的更频繁。
+ "-XX:GCTimeRatio"
    + 设置垃圾收集时间占总时间的比率
+ "-XX:+UseAdptiveSizePolicy"
    + JVM 会根据这个当前系统运行情况收集性能监控信息，动态调整一些参数（-Xmn\-XX:SurvivorRation等），以提供最合适的停顿时间或者最大的吞吐量
###3. -Xms512m -Xmx512m
#### 使用命令sb -u http://localhost:8088/api/hello -c 20 -N 60
```
167881  (RPS: 2426.2)
---------------Finished!----------------
Finished at 2020/10/28 21:36:41 (took 00:01:09.3061756)
Status 200:    167881

RPS: 2733.8 (requests/second)
Max: 13992ms
Min: 0ms
Avg: 2ms

  50%   below 0ms
  60%   below 0ms
  70%   below 0ms
  80%   below 0ms
  90%   below 1ms
  95%   below 2ms
  98%   below 3ms
  99%   below 5ms
99.9%   below 12ms
```
512m的内存下 Parallel GC 的吞吐量是2733.8/s

###4. -Xms1g -Xmx1g
```
Starting at 2020/10/28 21:44:25
[Press C to stop the test]
195955  (RPS: 2991.7)
---------------Finished!----------------
Finished at 2020/10/28 21:45:30 (took 00:01:05.6033442)
Status 200:    195955

RPS: 3206.8 (requests/second)
Max: 3138ms
Min: 0ms
Avg: 0.7ms

  50%   below 0ms
  60%   below 0ms
  70%   below 0ms
  80%   below 0ms
  90%   below 1ms
  95%   below 2ms
  98%   below 4ms
  99%   below 5ms
99.9%   below 12ms
```
在增大内存由512m -> 1G 以后，Parallel GC 的吞吐量变为3203.8/s。

###5. -Xms4g -Xmx4g
```
Starting at 2020/10/28 21:55:22
[Press C to stop the test]
247593  (RPS: 3800.6)
---------------Finished!----------------
Finished at 2020/10/28 21:56:28 (took 00:01:05.5378039)
Status 200:    247593

RPS: 4042.5 (requests/second)
Max: 890ms
Min: 0ms
Avg: 0.3ms

  50%   below 0ms
  60%   below 0ms
  70%   below 0ms
  80%   below 0ms
  90%   below 1ms
  95%   below 2ms
  98%   below 3ms
  99%   below 4ms
99.9%   below 8ms
```
内存在增加到 4G 以后，Parallel GC 的吞吐量变为4042.5/s。吞吐量明显比512m内存下增加很多。

## CMS GC
并发标记清理（Concurrent Mark Sweep，CMS）收集器也称为并发低停顿收集器（Concurrent Low Pause Collector）或低延迟（Low-Latency）垃圾收集器
###1. 特点
+ 针对老年代
+ 基于“标记-清除”算法（不进行压缩操作，产生内存碎片）以获取最短回收停顿时间作为目标
+ 并发收集、低停顿
+ 需要更多的内存
###2. 设置参数
+ "-XX:+UseConcMarkSweepGC"：指定使用CMS收集器；
###3. CMS收集器运作的过程
1. 初始标记（CMS initial mark）
2. 并发标记（CMS concurrent mark）
3. 重新标记（CMS remark）
4. 并发清除（CMS concurrent sweep）
5. Concurrent Sweep（并发清除）
6. Concurrent Reset（并发重置）
###4. -Xms512m -Xmx512m
#### 使用命令sb -u http://localhost:8088/api/hello -c 20 -N 60
```
Starting at 2020/10/28 22:14:09
[Press C to stop the test]
232120  (RPS: 3573.7)
---------------Finished!----------------
Finished at 2020/10/28 22:15:15 (took 00:01:05.0653730)
Status 200:    232120

RPS: 3797.7 (requests/second)
Max: 283ms
Min: 0ms
Avg: 0.3ms

  50%   below 0ms
  60%   below 0ms
  70%   below 0ms
  80%   below 0ms
  90%   below 1ms
  95%   below 2ms
  98%   below 3ms
  99%   below 4ms
99.9%   below 8ms
```
使用512M内存的吞吐量为3737.7/s。

###5. -Xms1g -Xmx1g
```
Starting at 2020/10/28 22:17:12
[Press C to stop the test]
228387  (RPS: 3511.2)
---------------Finished!----------------
Finished at 2020/10/28 22:18:17 (took 00:01:05.1636249)
Status 200:    228392

RPS: 3734.8 (requests/second)
Max: 241ms
Min: 0ms
Avg: 0.3ms

  50%   below 0ms
  60%   below 0ms
  70%   below 0ms
  80%   below 0ms
  90%   below 1ms
  95%   below 2ms
  98%   below 3ms
  99%   below 4ms
99.9%   below 9ms
```
使用1G内存的吞吐量为3734.8/s。

###6. -Xms4g -Xmx4g
```
Starting at 2020/10/28 22:09:43
[Press C to stop the test]
236571  (RPS: 3627.1)
---------------Finished!----------------
Finished at 2020/10/28 22:10:48 (took 00:01:05.2956468)
Status 200:    236571

RPS: 3871.4 (requests/second)
Max: 144ms
Min: 0ms
Avg: 0.3ms

  50%   below 0ms
  60%   below 0ms
  70%   below 0ms
  80%   below 0ms
  90%   below 1ms
  95%   below 2ms
  98%   below 3ms
  99%   below 4ms
99.9%   below 9ms
```
使用4G内存吞吐量为3871.4/s

对比发现，内存为512m、1G和4G的情况下，CMS GC 的吞吐量接近一致。和Parallel GC 相比，在4G内存下Parallel GC的吞吐量略优于CMS GC。

总体来看，与Parallel 垃圾收集器相比，CMS减少了执行老年代垃圾收集时应用暂停的时间；但却增加了新生代垃圾收集时应用暂停的时间、降低了吞吐量而且需要占用更大的堆空间；

## G1 GC
###1. 特点
+ 并行与并发：充分利用多CPU、多核环境的硬件优势可以并行缩短STW的停顿时间
+ 分代收集，收集范围包括新生代和老年代：能独立管理整个GC 堆，而不需要与其他收集器搭配
+ 结合多种垃圾收集算法，空间整合，不产生碎片
+ 可预测的停顿：低停顿的同时实现高吞吐量

###2. 配置参数
 + "-XX:+UseG1GC"：指定使用G1收集器；
 + "-XX:InitiatingHeapOccupancyPercent"：当整个Java堆的占用率达到参数值时，开始并发标记阶段；默认为45；
 + "-XX:MaxGCPauseMillis"：为G1设置暂停时间目标，默认值为200毫秒；
 + "-XX:G1HeapRegionSize"：设置每个Region大小，范围1MB到32MB；目标是在最小Java堆时可以拥有约2048个Region；

###3. -Xms512m -Xmx512m
#### 使用命令sb -u http://localhost:8088/api/hello -c 20 -N 60
```
Starting at 2020/10/28 22:46:19
[Press C to stop the test]
225318  (RPS: 3451.6)
---------------Finished!----------------
Finished at 2020/10/28 22:47:25 (took 00:01:05.5160031)
Status 200:    225319

RPS: 3683.3 (requests/second)
Max: 890ms
Min: 0ms
Avg: 0.4ms

  50%   below 0ms
  60%   below 0ms
  70%   below 0ms
  80%   below 0ms
  90%   below 1ms
  95%   below 2ms
  98%   below 3ms
  99%   below 4ms
99.9%   below 10ms
```

###4. -Xms1g -Xmx1g
```
Starting at 2020/10/28 22:34:00
[Press C to stop the test]
237986  (RPS: 3639.9)
---------------Finished!----------------
Finished at 2020/10/28 22:35:06 (took 00:01:05.6343043)
Status 200:    237989

RPS: 3892.3 (requests/second)
Max: 136ms
Min: 0ms
Avg: 0.2ms

  50%   below 0ms
  60%   below 0ms
  70%   below 0ms
  80%   below 0ms
  90%   below 1ms
  95%   below 2ms
  98%   below 3ms
  99%   below 4ms
99.9%   below 7ms
```
