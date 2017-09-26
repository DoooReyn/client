cc.FileUtils:getInstance():setPopupNotify(false)

----------------------------------------------------
local targetPlatform 				= cc.Application:getInstance():getTargetPlatform()
if targetPlatform == 0 then
	--设置开发目录为搜索路径
	cc.FileUtils:getInstance():addSearchPath('../../src/')
	cc.FileUtils:getInstance():addSearchPath('../../res/')

	--设置窗口大小
    local director 					= cc.Director:getInstance()
    local glView   					= director:getOpenGLView()
    glView:setFrameSize(1280,720)
    director:setOpenGLView(glView)
else
	cc.FileUtils:getInstance():addSearchPath('src/')
	cc.FileUtils:getInstance():addSearchPath('res/')
end
----------------------------------------------------

require "config"
require "cocos.init"
require "app.base.Func"

local function main()
	--设置随机种子数
	math.randomseed((os.time()) * 1000)
    require("app.MyApp").new():run()
end

local status, msg 					= xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
