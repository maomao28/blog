---
title: 解决使用RN老插件打包报错问题
date: 2021-04-13 09:43:57
tags:
---

rn 打包Task :react-native-orientation:verifyReleaseResources FAILED

使用react-native-orientation因为这个插件太老了的原因，apk打包时出错，解决方法如下

在node_modules找到react-native-orientation下android下的build.gradle文件改成新版的型号就好了

原来是这样的

{% asset_img 20200521210351668.png %}

改成这样的

{% asset_img 20200521210318613.png %}

重新打包 ok , 很多几年以前的包都有这个问题，这个方法也适用

转自：https://blog.csdn.net/printf_hello/article/details/106267597

