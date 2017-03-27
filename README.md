# JVShopcart
___
## 效果图
![](https://github.com/lll1024/JVShopcart/blob/master/gif/2017-03-25%2018.28.23.gif)

## 说明
这是一个比较常规的购物车模型 一共包含五个模块：

* `JVShopcartViewController`: 购物车控制器 负责协调Model和View 只有100多行代码
* `JVShopcartFormat`: 负责网络请求与逻辑处理
* `JVShopcartTableViewProxy`: 作为控制器里边TableView的代理
* `View`: 包括Cell、HeaderView、CountView(改变商品数的视图)、BottomView(控制器底部包含结算按钮的视图)
* `Model`: 包含BrandModel和ProductModel两层

## 使用
首先将工程里边的JVShopcart文件夹拖入你的项目 然后就是开源库Vendor文件夹根据需求处理 Model是一定会改的 但是购物车的Model大同小异 其他的改动不会太大 

## 有几个点需要注意：

* BrandModel里边有两个成员变量是手动添加进去的：isSelected和selectedArray前者是为了记录某个品牌或者说某个section是否被选中 后者是结算的时候记录选中的商品
* ProductModel里边的isSelected也是手动添加的 也是为了记录某个商品或者说某个row是否被选中
* Vendor文件夹里边是一些开源库 布局依赖Masonry 字典转模型依赖MJExtension 图片异步加载依赖SDWebImage 键盘的管理依赖IQKeyboardManager 当然你也可以自己处理
* View里边的回调都是用的Block JVShopcartFormat里边的回调都是用的delegate 你也可以根据需求自行选择具体的回调方式
* 虽然购物车大同小异 但是总有些奇葩的需求需要自己去处理 肯定是要根据我的注释去做一些修改的

以上如有帮助欢迎右上角star