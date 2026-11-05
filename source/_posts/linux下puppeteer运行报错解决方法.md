---
title: linux下puppeteer运行报错解决方法
date: 2021-02-03 15:48:08
tags:
---

linux 或 ubuntu 下运行puppeteer经常会报类似下面的错

`error while loading shared libraries: libnss3.so libXss.so.1 libasound.so.`

原因是缺少对应的库，根据提示安装缺失的库即可

linux下 apt install libXss

参考 https://blog.csdn.net/zhangpeterx/article/details/104210403

ubuntu下 yum install libXss
