---
title: webview打开时有瞬间白屏的问题
date: 2021-01-23 13:09:34
tags: [Android,H5]
---

### 遇到的效果是打开webview的时候会有白屏的效果，如下面这样

<div style="width:200px;margin:auto">
{% asset_img 1611378960352.gif %}
</div>

### 找了很久的原因，总结下来有这样几点

**1、 loadUrl的时间**

如果打开activity的时候webview已经加载了，但这个时候url由于各种原因还没有获取到，没有执行 webView.loadUrl，如果这样请先隐藏webview，准备好后再显示

**2、加载HTML的时间**

我的做法是webview先隐藏，等到HTML加载完后再显示

``` java
@Override
public void onPageFinished(WebView view, String url) {
    view.setVisibility(View.VISIBLE);
    super.onPageFinished(view, url);
}
```

---

如果这样打开时还是会有瞬间白屏的闪烁，那可能就要从网页端着手进行优化了

**3、网页打开时在html里直接给body设一个背景色**

因为网页的一些样式和图片是需要下载的，如果是单页面的话还要等JS下载完执行后才进行渲染，这都要时间

所以直接在html返回时就直接在页面里给页面元素定义个背景色

直接在head里给body设了背景图和背景色
``` html
<head>
  ...
  <style>
    body{
      background-image: url('./img/app-local-loading-bg.png');
      background-repeat: no-repeat;
      background-color: #5a0037;
      background-size:cover;
    }
  </style>
</head>
```