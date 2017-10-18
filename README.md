# JVShopcart
___

[Swift版本](https://github.com/linmaojia/MJShopCar)

## 效果图
<img src="https://github.com/lll1024/JVShopcart/blob/master/gif/2017-03-31%2010.43.23.gif" width="320" height="568" alt=""/>

## 说明
这是一个具备常规功能并方便改造的购物车模型 一共包含五个模块：

* `JVShopcartViewController`: 购物车控制器 负责协调Model和View 只有100多行代码
* `JVShopcartFormat`: 负责网络请求与逻辑处理
* `JVShopcartTableViewProxy`: 作为控制器里边TableView的代理
* `View`: 包括Cell、HeaderView、CountView(改变商品数的视图)、BottomView(控制器底部包含结算按钮的视图)
* `Model`: 包含BrandModel和ProductModel两层

## 使用
首先将工程里边的JVShopcart文件夹拖入你的项目 然后就是开源库Vendor文件夹根据需求处理 Model是一定会改的 但是购物车的Model大同小异 其他的改动不会太大 

关于`JVShopcartViewController`，由于其遵循JVShopcartFormatDelegate协议，而协议里边的方法都是用`@required`修饰的，所以必须要实现它；下面依次介绍这些方法：
```objc
- (void)shopcartFormatRequestProductListDidSuccessWithArray:(NSMutableArray *)dataArray;
- (void)shopcartFormatAccountForTotalPrice:(float)totalPrice
                                totalCount:(NSInteger)totalCount
                             isAllSelected:(BOOL)isAllSelected;
- (void)shopcartFormatSettleForSelectedProducts:(NSArray *)selectedProducts;
- (void)shopcartFormatHasDeleteAllProducts;
```
* 这是请求购物车列表成功之后的回调方法，将装有Model的数组回调到控制器；控制器将其赋给TableView的代理类`JVShopcartTableViewProxy`并刷新TableView。
* 这是用户在操作了单选、多选、全选、删除这些会改变底部结算视图里边的全选按钮状态、商品总价和商品数的统一回调方法，这条API会将用户操作之后的结果，也就是是否全选、商品总价和和商品总数回调给`JVShopcartViewController`， 控制器拿着这些数据调用底部结算视图BottomView的configure方法并刷新TableView，就完成了UI更新。
* 这是用户点击结算按钮的回调方法，这条API会将剔除了未选中ProductModel的模型数组回调给`JVShopcartViewController`，但并不改变原数据源因为用户随时可能返回。
* 这是用户删除了购物车所有数据之后的回调方法，你可能会做些视图的隐藏或者提示。

关于`JVShopcartFormat`，这个类主要负责网络请求与逻辑处理以及结果的回调。下面依次介绍这些方法：
```objc
- (void)requestShopcartProductList;
- (void)selectProductAtIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected;
- (void)selectBrandAtSection:(NSInteger)section isSelected:(BOOL)isSelected;
- (void)changeCountAtIndexPath:(NSIndexPath *)indexPath count:(NSInteger)count;
- (void)deleteProductAtIndexPath:(NSIndexPath *)indexPath;
- (void)starProductAtIndexPath:(NSIndexPath *)indexPath;
- (void)selectAllProductWithStatus:(BOOL)isSelected;
- (void)settleSelectedProducts;
```
* 这是请求购物车数据源的方法，大家一般都是对AFNetworking进行二次封装来请求数据。
* 这是用户选中了某个产品或某个row的处理方法，因为这会改变底部结算视图所以一定会回调上文协议中的第二个方法， 下同。
* 这是用户选中了某个品牌或某个section的处理方法
* 这是用户改变了商品数量的处理方法
* 这是用户删除操作的处理方法
* 这是用户收藏操作的处理方法，这里没有回调任何方法，也可以根据需求添加回调方法。
* 这是用户全选操作的处理方法
* 这是用户结算操作的处理方法

## 有几个点需要注意：

* BrandModel里边有两个成员变量是手动添加进去的：isSelected和selectedArray前者是为了记录某个品牌或者说某个section是否被选中 后者是结算的时候记录选中的商品
* ProductModel里边的isSelected也是手动添加的 也是为了记录某个商品或者说某个row是否被选中
* Vendor文件夹里边是一些开源库 布局依赖Masonry 字典转模型依赖MJExtension 图片异步加载依赖SDWebImage 键盘的管理依赖IQKeyboardManager 当然你也可以自己处理
* View里边的回调都是用的Block JVShopcartFormat里边的回调都是用的delegate 你也可以根据需求自行选择具体的回调方式
* 虽然购物车大同小异 但是总有些奇葩的需求需要自己去处理 肯定是要根据我的注释去做一些修改的

以上如有帮助欢迎右上角star
