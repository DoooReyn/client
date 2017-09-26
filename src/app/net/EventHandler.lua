local EventHandler 					= class("EventHandler")

function EventHandler:ctor()
end

----------------------------------------消息接收----------------------------------------
--根据消息名字进行派发（一次性的消息可以直接派发到自己模块）
function EventHandler:recv(msgName, protoMsg)
	if msgName == 'TickRequestNullUserPmd_CS' then
		--心跳包 同步时间
		dataMgr.BaseData:setServerTimer(protoMsg.requesttime)
		self:TickReturnNullUserPmd_CS(protoMsg.requesttime)
		return
	elseif msgName == 'stUserInfoSelectUserCmd' then
		loadingEffects:hideLoadingEf()
		sceneMgr:returnRole(protoMsg)
		return
	elseif msgName == 'UserLoginReturnFailLoginUserPmd_S' then
		--登录失败
		net:close()
		loadingEffects:hideLoadingEf()
		publicNotice:sendNormalNotice("亲，您的网络已经断开，请重新登录!")
        sceneMgr:returnLogin()
		return
	elseif msgName == 'stUserReLoginLogonUserCmd' then
		net:close()
		net:showNetTip(2)
		return
	end
    
	--消息派发
	dispatchEventLua(msgName, protoMsg)
end

----------------------------------------消息发送----------------------------------------

----------------------------------------登录消息----------------------------------------
--请求服务器列表
function EventHandler:RequestZoneInfoListLoginUserPmd_C(gameId)
	local msg 			= {
		gameid 			= gameId,
	}
	net:send("RequestZoneInfoListLoginUserPmd_C",msg,true)
end


return EventHandler
