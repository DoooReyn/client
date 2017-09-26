local UpdateUI 						= class("UpdateUI", function()
    return display.newLayer()
end)

function UpdateUI:ctor(scene)
	self.scene 				= scene
	self.failCount         	= 0
	
	local csbName 			= 'csb/UpdateUI.csb'
    local csbLay 			= cc.CSLoader:createNodeWithVisibleSize(csbName)
    self:addChild(csbLay)
    local root 				= csbLay:getChildByName('Panel_UI')
    self.Image_Probg        = ccui.Helper:seekWidgetByName(root,'Image_Probg')
    self.Loading_Bar     	= ccui.Helper:seekWidgetByName(root,'Loading_Bar')
    self.Text_ProDes     	= ccui.Helper:seekWidgetByName(root,'Text_ProDes')
    self.SysTipLay     		= ccui.Helper:seekWidgetByName(root,'SysTipLay')
    local continueBtn 		= self.SysTipLay:getChildByName('Button_Continue')
   	continueBtn:setPressedActionEnabled(true)
   	continueBtn:addClickEventListener(handler(self, self.continueUpdate))
    self.Image_Probg:setVisible(false)
	self.SysTipLay:setVisible(false)
	
    local function onEventHandler(eventType)  
        if eventType == "enter" then  
            self:onEnter() 
        elseif eventType == "exit" then
            self:onExit()
        end
    end
    self:registerScriptHandler(onEventHandler)
end

function UpdateUI:onEnter()
	self._listener1 = addEventLua("UpdateProgress_Msg", handler(self, self.updateProgress))
	self._listener2 = addEventLua("UpdateFail_Msg", handler(self, self.updateFail))
	self._listener3 = addEventLua("UpdateSuccess_Msg", handler(self, self.updateSucceed))
    
	if not isEnableUpdate() then
		performWithDelay(self, handler(self, self.updateSucceed), 0.01)
	else
		startUpdateSrc()
	end
end

function UpdateUI:onExit()
	removeEventLua(self._listener1)
	removeEventLua(self._listener2)
	removeEventLua(self._listener3)
end

--继续更新
function UpdateUI:continueUpdate()
	self.SysTipLay:setVisible(false)
	startUpdateSrc()
end


-------------------------更新回调------------------------
--更新进度
function UpdateUI:updateProgress(event)
	local msg = event._usedata
	self.Loading_Bar:setPercent(msg.percent)
	self.Image_Probg:setVisible(true)
end

--更新成功
function UpdateUI:updateSucceed(event)
	self.Loading_Bar:setPercent(100)
	cc.exports.sceneMgr = require("app.manager.SceneMgr").new()
	sceneMgr:init(self.scene)
end

--更新失败
function UpdateUI:updateFail(event)
	self.failCount = self.failCount + 1
	if self.failCount < 2 then
		startUpdateSrc()
		return
	end

	local customId = event._usedata
	local desLab = self.SysTipLay:getChildByName('Text_ErrorDes')
	local desStr1 = string.format('亲爱的玩家，由于网络不稳定，更新文件(%s)失败，请检查网络是否正常连接！', customId)
	local desStr2 = string.format('如果仍无法解决问题，请联系客服QQ：%s', CustomerServiceQQ)
	desLab:setString(desStr1 .. desStr2)
	self.SysTipLay:setVisible(true)
end

return UpdateUI
