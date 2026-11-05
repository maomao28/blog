---
title: android.permission.MODIFY_PHONE_STATE 权限获取
date: 2021-04-26 15:48:56
tags: Android
---

这是一个Android的系统权限，Android是不允许第三方应用获取此权限的，解决方案是把他设成内置应用。

## 如何设为内置应用

需要把apk文件放到 /system/priv-app 目录下；
1、可以通过 usb 连接到电脑，然后通过adb shell命令，然后 sudo 拿到管理员权限（要root后才行）, 拿到权限后就可以插入文件了
2、建议建个文件夹然后把apk放在文件夹下 比如 /system/priv-app/xxx/xxx.apk
3、插入完成后重启下手机应用就会自动安装


## 如何删除内置应用

把 /system/priv-app 下的apk文件和oat目录一起删除，然后重启
