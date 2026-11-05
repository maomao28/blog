---
title: next.js ssr渲染 时跳转404操作
date: 2022-11-03 15:17:01
tags: H5,next.js
---


在某些情况下如果需要跳转404，在 getServerSideProps 方法内返回  notFound:true

```
return {
    notFound:true
}
```

如果要重写404页面，可以在pages下新建一个404.js进行改写