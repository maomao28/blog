---
title: Babel笔记
date: 2021-08-05 14:28:19
---
## 什么是Babel

Babel 是一个工具链，主要用于将采用 ECMAScript 2015+ 语法编写的代码转换为向后兼容的 JavaScript 语法，以便能够运行在当前和旧版本的浏览器或其他环境中。
就是将 ES6 转成 ES5 浏览器支持的代码

//当前浏览器的兼容情况
https://kangax.github.io/compat-table/es6/ 

//在线工具测试
https://www.babeljs.cn/repl

## 如何运行Babel

`./node_modules/.bin/babel src --out-dir lib`

可以写成

`npx babel src -d lib`

## 插件

### 语法插件(Syntax Plugins)
```json
{
  "parserOpts": {
    "plugins": ["jsx", "flow"] //flow是静态语法检查
  }
}
```
parser的参数
```
allowImportExportEverywhere,
allowAwaitOutsideFunction,
allowReturnOutsideFunction,
allowSuperOutsideMethod,
...
```
具体说明：https://babel.docschina.org/docs/en/babel-parser/#options


