# EXTENDED NETWORK 

## 来源

> Via: https://github.com/bstabler/TransportationNetworks/tree/master/SiouxFalls

## 包含文件
## 程序
`networkOD.m`：处理网络的主程序

`test.m`：绘制网络的程序

`plotODNetwork.m`：绘制网络的函数

`nodesprocedure.m`：处理节点的程序

`findDemand.m`：查询Demand的函数

## 数据
`SiouxFalls_OD.csv`：初始OD数据源

`links.mat`：初始links数据源

`ExtendedNetwork.mat`：最终结果数据

`ExtendedOD.xlsx`：OD列表导出

`linksCopy_order.xlsx`：link列表导出（按照link_o排序）

`ExtendedNetwork.fig`: 绘制网络结果
## 网络可视化
![](https://qqadapt.qpic.cn/txdocpic/0/67ebed8b1552686f27f287e41c834357/0)
## 流程
1    运行networkOD.m得到扩展网络数据

2	运行test.m得到绘制网络





