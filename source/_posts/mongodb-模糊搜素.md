---
title: mongodb 全文搜索
date: 2022-05-19 15:25:29
tags: mongodb
---

## 1、比较low的处理方式

通过正则来匹配关键字来查询，查找字段内容是否包含你要查询的关键字

就是类似sql里like的查询方式

select * from table where xx like yy

```
db.user.find({"name":/xx/})

或者

db.user.find({"name":{
    $regex: new RegExp('xx'),
    $options: '$i'
}})
```

## 2、类似Elastic Search、Solr等全文搜索的查询方式

其实搜索原理主要还是基于分词，其实mongodb自带这个功能

http://www.ttlsa.com/mongodb/mongodb-full-text-search-mongodb-ttlsa-tutorial-series/

### 第一步 先给要搜索的字段添加索引

```
db.books.createIndex({
	"title":"text",
	"desc":"text" //哪些字段需要查询，就添加哪些
})
```

### 第二步 如果是中文的话， 需要手动将这些字段进行分词（英文直接跳过）

这些是mongodb直接支持的语言
https://www.mongodb.com/docs/v6.0/reference/text-search-languages/

以node环境为例，中文的话推荐使用 NodeJieba
https://www.npmjs.com/package/nodejieba

```
npm install nodejieba

var nodejieba = require("nodejieba");
var result = nodejieba.cut("南京市长江大桥");
console.log(result);
//["南京市","长江大桥"]
```

将分好的词以空格分隔保存到数据库，建议新建个字段保存，搜索时也已该字段查询

### 第三步 查询
```
db.collection1.find({$text: { $search: inputValue}})

# 还可以按照相似度加上排序

db.collection1.find({
    $text: { $search: inputValue}}, 
    {score: {$meta: "textScore"}}
)
.sort({ score:{$meta: "textScore"} })
```

1. 一个查询最多可以指定一个$text表达式。
2. $text查询不能出现在$nor表达式中。
3. $text查询不能出现在$elemMatch查询表达式或$elemMatch表达式中。
4. 要$text在$or表达式中使用查询，$or必须对数组中的所有子句都建立索引。
5. hint()如果查询包含$text查询表达式，则无法使用。
6. $natural如果查询包含$text表达式，则不能指定排序顺序。
7. 不能将$text需要特殊文本索引的表达式与需要不同类型特殊索引的查询运算符组合在一起。例如，不能将$text表达式与$near运算符结合在一起。
8. 视图不支持文本搜索。

参考文档:
https://blog.csdn.net/qq_39657585/article/details/108431397

https://mongoing.com/archives/81357

