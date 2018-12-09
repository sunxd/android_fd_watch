# 查看APP使用FD, THEAD情况
---
## 1.说明 watch_fd.sh  查看FD

类似以下的Crash，做Android的同学应该都不陌生，尤其是华为抓机。一般Android系统的FD限制多为1024，当超过该值，就会引起崩溃，堆栈包括但不限于以下几种：

* FD leaks, File Description Leaks, Too many open files, error 24
* FORTIFY: FD_SET: file descriptor >= FD_SETSIZE
* pthread_create (1040KB stack) failed: Out of memory

那么，赶紧看看系统的FD占用情况吧，也许罪魁祸首就是它

## 使用方法

```shell
./watch_fd.sh  com.xxx.zzz
```
## 输出
```shell
Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
```

## 2.说明 watch_thread.sh 查看线程
跟据输入的包名，查看系统线程使用情况，默认每10秒比较一次，以脚本执行时的线程数为基准，打印出新增线程的名子。
	
## 使用方法

```shell
./watch_thread.sh  com.xxx.zzz   
```

## 输出
```shell
Org Total Thread: 153   //脚本运行的线程数
Crt Total Thread: 156	 //10秒后的线程数
New Thread Name:	     //以下是新增线程名子
xxx_word_co
xxxio
thread_xxx
-------------------
Press CTRL+C To Stop.
```
	