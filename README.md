# hook_up_rent

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.





### 注：此项目需要搭建本地服务器(不懂后台的小白也完全没难度噢，动手吧^o^)

### 搭建所需的数据库文件由此下载，链接: https://pan.baidu.com/s/1wRHoBkXKLqfVO2T88U4xhA 提取码: hkzf 

# 1、首先下载工具 phpstudy(或者同类型的工具，随个人喜欢，本博主不太懂后端，随便找了一个)

# 2、新建数据库
## 数据库说明
- 默认数据库名称为：`hkzf`
- 数据库用户名：`root` 密码：`root`（有些工具的数据库不能使用root，可以起一个自己喜欢的噢，记得同步修改config/mysql.js就可以了(*^^*)）
- 如果要修改可以在 `config/mysql.js` 中手动修改，然后，重新启动接口服务即可

# 3、数据库导入数据库文件，运行
数据库文件路径：数据库相关文件/hkzf_v1/db/hkzf_db.sql

# 4、打开终端，输入命令
cd *** /hkzf_v1

npm start

如无意外就会显示数据库连接成功，本地服务就搭建好了^o^


# 5、使用vscode打开项目，运行项目
终端输入：flutter run --no-sound-null-safety

