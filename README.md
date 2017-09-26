# 目录结构
**@cxx    2017/9/16** 


----------


```
client--> |--> cocosstudio
			  |--> XXUI.csd
			  |--> XXNode.csd
			  |--> 模块资源(后期res下资源打包后原资源提交到这里)
		  |--> simulator(windows模拟器)	
          |--> res
              |--> csb(UI配置文件)
              |--> font
              |--> frames(帧动画)
	               |--> 特效
	               |--> 技能
	               |--> 角色...
              |--> icon
	               |--> buff
	               |--> props
	               |--> skill...
              |--> map
	               |--> block
	               |--> minMap
	               |--> tmx
              |--> music
              |--> particle
              |--> proto
              |--> ui
	               |--> bg  
	               |--> extent
	               |--> public
	               |--> load(后期出马甲包换皮资源抽出来)
	               |--> xx.plist/xx.pvr.ccz
          |--> src/app    
              |--> base(基础第三方库)
	          |--> config(excel to Lua)
	          |--> control(战斗核心)
	          |--> data(数据中心MVC)
	          |--> manager(管理类)
	          |--> net(网络处理)
	          |--> script(策划手写脚本)
	          |--> utils(公共类集合)
	          |--> views(UI)
		           |-->UIBase.lua
		           |-->XXUI.lua
		           


----------


```

	 
# 规则说明

 - 命名规则：
1. 目录名一律小写，如：main、proto
2. 美术资源名以对应目录名为前缀，下划线加阿拉伯数字递增形式为后缀，如：main_1.png、main_2.png
3. 脚本大写开头，一般以对应类型为后缀，如：MainUI、UIMgr、BaseData、BasePropsConfig

 - 资源规则：
1. 大背景图统一放bg目录，一般用jpg格式
2. 使用频率高的常用通用资源放public，后期统一打包
3. 个别模块共用资源放extent，不打包
4. 其它资源放自己对应模块，后期一般统一打包(注意不要引用除公共资源外其它模块资源)
