---
title: 解决Android下载gradle慢的问题
date: 2021-01-19 15:29:00
tags: Android
---

## 使用国内镜像进行替换加速

1. 打开工程文件根目录 build.gradle

2. 在 buildscript 和 allprojects 的 repositories 中分别注释掉 jcenter()，并使用国内镜像进行替换：maven{url 'http://maven.aliyun.com/nexus/content/groups/public/'}

3. 在 buildscript 的 repositories 添加：maven{url "https://jitpack.io"}

``` json
buildscript {
    repositories {
        maven{url 'http://maven.aliyun.com/nexus/content/groups/public/'}
        maven{url "https://jitpack.io"}
//        jcenter()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:2.2.0'

        // NOTE: Do not place your application dependencies here; they belong
        // in the individual module build.gradle files
    }
}

allprojects {
    repositories {
        maven{url 'http://maven.aliyun.com/nexus/content/groups/public/'}
//        jcenter()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
```

最后发现心里感觉会快些。。。

----

实在忍不住可以尝试手动下载gradle
参考：https://www.jianshu.com/p/558e5955bfbd?from=singlemessage
ps: 最后复制一份gradle-x.x.x-all.zip.lck文件，重命名为gradle-x.x.x-all.zip.ok；
