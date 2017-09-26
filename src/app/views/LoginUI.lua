local LoginUI 						= class("LoginUI", UIMgr:loadBase("UIBase"))

function LoginUI:init()
    self.widget 					= {
    	{"ListView_1"},
    }
end

function LoginUI:onEnter()
	self._listener = addEventLua('ZoneInfoListLoginUserPmd_S', handler(self, self.refreshServerList))
	dataMgr.LoginData:reqServerList()
end

function LoginUI:onExit()
	removeEventLua(self._listener)
end


function LoginUI:refreshServerList()
	self.ListView_1:removeAllChildren()
	for i,v in ipairs(dataMgr.LoginData.allServerList) do
		local item = ccui.Text:create(v.zonename .. v.zoneid .. v.state, "", 30)
		self.ListView_1:pushBackCustomItem(item)
	end
end

return LoginUI
