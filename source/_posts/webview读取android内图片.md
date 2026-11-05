---
title: webview读取android内图片
date: 2021-01-15 15:53:24
tags: Android
---

为了进一步优化Android内网页的打开速度，准备将静态图片全都放进app内，不再去请求网络。

曾尝试直接在网页里把图片地址写成 

```
file:///android_asset/xxx.png
```

图片虽然存在，但浏览器会报
```
Not allowed to load local resource
```

为了解决这个问题需要换一个思路，通过拦截webview的request请求，然后返回本地图片来解决

判断如果图片名称包含app-local的，并且app内有这张图片的，便直接返回应用内的图片

```java
@Override
public WebResourceResponse shouldInterceptRequest(WebView view, WebResourceRequest request) {

    String url = request.getUrl().toString();

    AssetManager assets = mContext.getResources().getAssets();

    if (url.contains("app-local")) {
        String fileName = "";
        Pattern pat=Pattern.compile("[\\w-]+[\\.][\\w-]+[\\.](\\w)+.$");//正则判断
        Matcher mc=pat.matcher(url);//条件匹配
        while(mc.find()) {
            fileName= mc.group();//截取文件名后缀名
            fileName = fileName.replaceAll("\\.(\\w+)\\.",".");
        }

        if(fileName!=""){
            InputStream input = getClass().getResourceAsStream("/assets/cacheImg/"+fileName);
            if(input!=null){
                WebResourceResponse response = new WebResourceResponse("image/png", "UTF-8", input);
                return response;
            }
        }
    }

    return  super.shouldInterceptRequest(view, request);
}
```
