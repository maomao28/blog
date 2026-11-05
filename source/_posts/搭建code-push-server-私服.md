---
title: 搭建code-push-server-私服
date: 2021-09-02 14:52:51
tags: react-native
---

为了支持React Native的热更新，搭建code-push-server私服

#### 1、如果没有mysql的服务，先安装mysql

#### 2、搭建node环境，然后安装code-push-server
```
    npm install code-push-server -g
```

#### 3、初始化mysql数据库
 ```
    code-push-server-db init --dbhost localhost --dbuser root --dbpassword --dbport 3306
```

如果mysql是5.0以上的版本会报错，解决方法如下

* 通过命令行进入解压的mysql根目录下。
* 登陆数据库
```
  mysql -uroot -p
```

* 输入root的密码 
```
  Enter password: ******
```

* 更改加密方式（原样拷贝到命令窗中） 
```
   mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;
```

* 更改密码：该例子中 123456为新密码 
```
  mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123456';
```

* 刷新： 
```
   mysql> FLUSH PRIVILEGES;
```

参考 https://www.cnblogs.com/taohuaya/p/11401109.html

#### 4、初始化成功后，启动code-push-server

启动前可在code-push-server的config里设置数据库的host与账号

``` json
db: {
    username: process.env.RDS_USERNAME || "root",
    password: process.env.RDS_PASSWORD || null,
    database: process.env.DATA_BASE || "codepush",
    host: process.env.RDS_HOST || "127.0.0.1",
    port: process.env.RDS_PORT || 3306,
    dialect: "mysql",
    logging: false,
    operatorsAliases: false,
  }
```

当然也可以在启动时设置环境变量
```
PORT=3000 pm2 start code-push-server
```

#### 5、在本地安装code-push-cli来连接server

这里有坑，不要安装最新版，安装2.1.9版本

```
cnpm install -g code-push-cli@2.1.9      
```

#### 6、连接server

```
 code-push login http://host:port
```


