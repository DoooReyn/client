local Net 							= class("Net")
Net.__index 						= Net

function Net:ctor()
	--是否第一次登录
    self.isSendSeq                  = false
    self.seq                        = -1
    self.lastRecvTime               = 0
    self.isNetSysTip                = false
    self.isReconnecting             = false
    self.isPay                      = false
    self.isActiveExit               = false  
    self.isRefreshBuf               = false
end

--连接登录服务器
function Net:connectLogin(rhand)
    if isConnect() then
        --断开连接
        self:close()
    end
    
    self.rhand                      = rhand
    local svrUrl                    = dataMgr.LoginData.loginSvrUrl
    connect(svrUrl[1], svrUrl[2])
    self.lastRecvTime               = 0
end

function Net:connect(rhand)
	if isConnect() then
    	--断开连接
    	self:close()
    end
    
    self.rhand                      = rhand
    connect(self.ip, self.port)
    self.lastRecvTime               = 0
end

-- 连接返回
function Net:connectRhand()
    printInfo("连接成功")
	if self.rhand then
		self.rhand()
	end
end

function Net:connectFhand()
    printInfo("连接断开")
    loadingEffects:hideLoadingEf()
    disconnect()
    self.rhand          = nil

    local netCsb        = sceneMgr.uiLayer:getChildByName('sysTip_net')
    if netCsb then
        if self.isReconnecting then
            publicNotice:sendNormalNotice("亲,请检查网络是否正常连接哦!")
        end
        return
    end

    self:showNetTip(1)
end

function Net:showNetTip(nType)
    if self.isActiveExit then
        self.isActiveExit = false
        return
    end

    local loginLay      = UIMgr:getObj('login')
    if loginLay then
        if nType == 2 then
            publicNotice:sendNormalNotice("您的账号已在别处登陆，如非本人操作,请及时修改密码")
        else
            publicNotice:sendNormalNotice("亲,你的网络不给力哦,请重新登录!")
        end
        return
    end
    
    local sysFightTip = sceneMgr.uiLayer:getChildByName('sysTip_fight')
    if sysFightTip then
        sysFightTip:removeFromParent()
    end

    guide:closeGuide()
    stateMachine:resetState()

    local function callback(result)
        if result == 1 then
            sceneMgr:returnLogin()
        elseif result == 2 then
            self:reqReconnect()
        else
            sceneMgr:returnLogin()
        end
    end
    
    local str       = nil
    if nType == 2 then
        str         = {text = '您的账号已在别处登陆，如非本人操作,请及时修改密码'}
    else
        str         = {text = '亲爱的玩家，当前游戏已掉线，请检查网络是否正常连接哦'}
    end

    local roleLay   = UIMgr:getObj('createRole')
    local netCsb    = nil
    if roleLay or nType == 2 then
        netCsb      = publicNotice:sendSysTipNode(str, {'返回登录'}, callback, 40)
    else
        netCsb      = publicNotice:sendSysTipNode(str, {'返回登录', '重新连接'}, callback, 40)
    end

    self.isNetSysTip                = true
    local function onEventHandler(eventType)
        if eventType == "exit" then
            net.isNetSysTip         = false
        end
    end
    netCsb:registerScriptHandler(onEventHandler)
end

function Net:close()
	disconnect()
end

function Net:recv(msgBody)
    if not isConnect() then
        return
    end

	--解析消息体
	local bodyCode 					= protobuf.decode("Pmd.ForwardNullUserPmd_CS", msgBody)
    
    local byCmd 					= 0 	--主消息号
    local byParam 					= 0 	--子消息号
    if bodyCode.byCmd then
    	byCmd 						= bodyCode.byCmd
    end

    if bodyCode.byParam then
    	byParam 					= bodyCode.byParam
    end
    
    self.seq                        = bodyCode.seq
    self.lastRecvTime               = os.time()
    -- printInfo("seq:%d, 消息号:%d, %d", self.seq, byCmd, byParam)

    if not bodyCode.data then
    	printError("data is null")
    	return
    end
     
    --解包
    local msgName 					= messageFactory:getName(byCmd, byParam)
    if not msgName then
    	printInfo("消息号没有注册！")
    	return
    end
    
    local protoMsg 					= protobuf.decode(msgName, bodyCode.data)
    if not protoMsg then
    	printError("protoMsg is null")
    	return
    end
    
    --拆分消息名字
    local arr 						= string.split(msgName, ".")
    local name 						= arr[2]

    --打印消息
    --printInfo("消息接收:%s", name)
    --dump(protoMsg, name)
     
    --重连逻辑
    if self.isReconnecting then
        self.isReconnecting = false
        loadingEffects:hideLoadingEf()
        sceneMgr.uiLayer:removeChildByName('sysTip_net')
    end

    --消息派发
    eventHandler:recv(name, protoMsg)
end

function Net:send(name, msg, isPmd)
    if not isConnect() then
        --self:connectFhand()
    	return
    end

    if not name or not msg then
    	printInfo("send param error!")
    	return
    end
    
    --拼接消息名字
    local msgName 					= ""
    if isPmd then
    	msgName                     = "Pmd." .. name
    else
    	msgName                     = "GameCmd." .. name
    end

	--打包协议
	local value 					= messageFactory:getValue(msgName)
	if not value then
		printError("msg value error!")
		return
	end
    
    --打印消息
    -- dump(msg, name)

	local msgCode                   = protobuf.encode(msgName, msg)
	if not msgCode then
		printInfo("msg encode error!")
		return
	end

	--打包整个消息
	local protoBody 				= {
		byCmd 						= value.byCmd,
		byParam 					= value.byParam,
		--发送时间
		time                        = os.time(),
		data                        = msgCode,
	}

    if not self.isSendSeq then
        self.isSendSeq              = true
        --protoBody.bitmask           = 16
    end
    
    local protoCode                 = protobuf.encode("Pmd.ForwardNullUserPmd_CS", protoBody)
	local len 						= string.len(protoCode)
    
    len                             = send(protoCode, len)
    --打印消息
    --printInfo("消息发送:len=%d", len)
end

-- 请求断线重连
function Net:reqReconnect()
    guide:closeGuide()
    self.isReconnecting             = true
    loadingEffects:showLoadingEf()
    self:connect(handler(self, self.reconnected))
end

-- 重新连接成功
function Net:reconnected()
    self.isSendSeq                  = false
    self.isRefreshBuf               = true
    eventHandler:reqEnterCreateRole(self.seq, dataMgr.RoleData.dwRoleID)
    eventHandler:SetTickTimeoutNullUserPmd_CS(2)
end

function Net:isConnect()
	return isConnect()
end

--游戏从后台进入前台
function Net:enterForeground()
    local loginLay = UIMgr:getObj('login')
    if loginLay then
        return
    end

    local roleLay = UIMgr:getObj('createRole')
    local curTime = os.time()
    local sTime = curTime - self.lastRecvTime

    if sTime > 60 then
        self.lastRecvTime = curTime - 37
    else
        self.lastRecvTime = 0
    end

    if not isConnect() then
        if roleLay then
            if sTime <= 60 then
                disconnect()
                self:reqReconnect()
            end
        else
            disconnect()
        end
        return
    end

    eventHandler:TickRequestNullUserPmd_CS()
end

function Net:checkNet()
    if self.isReconnecting or self.isNetSysTip then
        return true
    end
    
    if not isConnect() then
        printInfo("网络断开开始重连")
        self:reqReconnect()
        return true
    end

    if self.isPay then
        return false
    end
   
    if self.lastRecvTime <= 0 then
        return false
    end

    local sTime = os.time() - self.lastRecvTime
    if sTime > 38 then
        printInfo("网络超时开始重连:%d", sTime)
        self:reqReconnect()
        return true
    end

    return false
end

return Net