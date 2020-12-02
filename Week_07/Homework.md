学习笔记
# Week07 作业题目（周四）：
## 1.通过Java程序生成数据
通过GenerateSQLData程序生成各个表的随机数据，数据量100W
1. user_info表对应数据 user_info.txt
2. user_address表对应 user_address.txt
3. product_company表对应 product_company.txt
4. product_info表对应 product_info.txt
5. product_model表对应 product_model.txt
6. order_info表对应 order_info.txt
7. order_detail表对应 order_detail.txt

## 2.通过命令导入数据
### 1.导入user_info表数据
<pre><code>
mysql> load data local infile "E:\\Program\\Learing\\JavaTraining\\Course\\user_info.txt" into table user_info character set utf8 fields terminated by ',';
Query OK, 1000000 rows affected (32.13 sec)
Records: 1000000  Deleted: 0  Skipped: 0  Warnings: 0
</code></pre>
### 2.导入其他表类似
<pre>
...
</pre>
