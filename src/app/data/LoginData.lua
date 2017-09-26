local LoginData 					= {}

function LoginData:ctor()
	--测试登录服务器地址
    self.loginSvrUrl                = {'112.74.41.86', 47000}
    --正式登录服务器地址
    --self.loginSvrUrl              = {'112.74.41.86', 47000}

    self.allServerList              = {}
end

--消息注册
function LoginData:addEvent()
    self.msgList                    = {
    	ZoneInfoListLoginUserPmd_S 	= handler(self, self.reqServerListCallback),
    }
end

--请求server list
function LoginData:reqServerList()
	local function connectRhand()
		printInfo("reqServerList")
		eventHandler:RequestZoneInfoListLoginUserPmd_C(3002)
	end
	net:connectLogin(connectRhand)
end

--请求server list
function LoginData:reqServerListCallback(event)
	net:close()
	local msg                       = event._usedata
	--服务器排序
	local function comp(v1, v2)
		if v1.zoneid > v2.zoneid then
			return true
		else
			return false
		end
	end

	--清空服务器列表
    self.allServerList          	= {}

    for k,v1 in pairs(msg.zonelist) do
		--单个服务器数据
		local svrInfo 				= {}
		local zoneid 				= v1.zoneid
		svrInfo.zoneid 				= zoneid
		svrInfo.newzoneid   		= v1.newzoneid
		svrInfo.zonename 			= v1.zonename
		svrInfo.state 				= v1.state
		if not svrInfo.state then
			svrInfo.state 			= 0
		end

		table.insert(self.allServerList, svrInfo)
	end

    dump(self.allServerList)
end






return LoginData
