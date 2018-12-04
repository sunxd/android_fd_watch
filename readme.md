# 查看APP使用FD情况, FD泄漏
---
## 说明

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
-e Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
-e Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
-e Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
-e Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
-e Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
-e Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
-e Watching App com.xxx.zzz<pid>, Current FD 364. Press CTRL+C to stop.
```
	
	