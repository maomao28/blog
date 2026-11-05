---
title: React Native开发的电影下载与播放平台
date: 2021-04-21 18:04:38
tags:
---

## 一个React Native开发的电影下载与播放平台

### 源码 

https://github.com/delicious28/mm_movie

### 效果

<div style="width:200px;margin-right:20px;display:inline-block">
    {% asset_img S10421-17555013.png 200%}
</div>
<div style="width:200px;margin-right:20px;display:inline-block">
    {% asset_img S10421-17560083.png 200%}
</div>

### 关于电影下载

电影是通过aria2下载到服务器，下载时也是服务器实时获取aria2的进度返回的

### 关于播放

为了方便在电视机顶盒上播放，目前是通过手机自带播放器播放的。

不过 android代码里有接入过饺子视频组件（ https://github.com/Jzvd/JZVideo ），把注释的代码放开即可使用；

