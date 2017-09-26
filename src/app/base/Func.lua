--[[
TODO:热更新这个文件，得重启才能生效
]]

----------------------------网络相关开始----------------------------
-- 连接成功
local function connectRhandLua()
    net:connectRhand()
end
cc.exports.connectRhandLua          = connectRhandLua

-- 连接失败
local function connectFhandLua()
    net:connectFhand()
end
cc.exports.connectFhandLua          = connectFhandLua

-- 网络连接数据
local function recvMsgLua(msgBody)
    net:recv(msgBody)
end
cc.exports.recvMsgLua               = recvMsgLua
----------------------------网络相关结束----------------------------


----------------------------更新接口开始----------------------------
-- 更新成功
local function updateSucceedLua(customId)
    if util then
        util:setExtendResInfo(customId)
    end

    dispatchEventLua('UpdateSuccess_Msg', customId)
end
cc.exports.updateSucceedLua         = updateSucceedLua

-- 更新进度
local function updateProgressLua(customId, percent)
    local usedata                   = {}
    usedata.customId                = customId
    usedata.percent                 = percent

    if util then
        util:setExtendResInfo(customId, percent)
    end
    
    dispatchEventLua('UpdateProgress_Msg', usedata)
end
cc.exports.updateProgressLua        = updateProgressLua

-- 更新失败
local function updateFailLua(customId)
    dispatchEventLua('UpdateFail_Msg', customId)
end
cc.exports.updateFailLua            = updateFailLua
----------------------------更新接口结束----------------------------


----------------------------SDK相关开始-----------------------------
-- 平台回调接口
local function platformEventHandlerLua(eventtype, response, token)
    if not dataMgr or not dataMgr.LoginData then
        return
    end

    dataMgr.LoginData:eventToLua(eventtype, response, token)
end
cc.exports.platformEventHandlerLua  = platformEventHandlerLua

-- 语音回调接口
local function voiceEventHandlerLua(eventtype, response)
    if not UIMgr then
        return
    end

    local chat = UIMgr:getObj('chat')
    if chat then
        chat:sendSound(eventtype,response)
    end
end
cc.exports.voiceEventHandlerLua     = voiceEventHandlerLua
----------------------------SDK相关结束-----------------------------


----------------------------消息接口开始----------------------------
local eventDispatcher               = cc.Director:getInstance():getEventDispatcher()
-- 派发事件
local function dispatchEventLua(name, usedata)
    if name == nil then
        return
    end

    local event                     = cc.EventCustom:new(name)
    if usedata then
        event._usedata              = usedata
    end

    eventDispatcher:dispatchEvent(event)
end
cc.exports.dispatchEventLua         = dispatchEventLua

-- 删除事件
local function removeEventLua(listener)
    if listener == nil then
        return
    end

    eventDispatcher:removeEventListener(listener)
    listener                        = nil
end
cc.exports.removeEventLua           = removeEventLua

-- 注册事件
local function addEventLua(name, func)
    if name == nil or func == nil then
        return
    end
    
    local listener                  = cc.EventListenerCustom:create(name, func)
    eventDispatcher:addEventListenerWithFixedPriority(listener, 1)
    
    return listener
end
cc.exports.addEventLua              = addEventLua
----------------------------消息接口结束----------------------------


--进入前台
local function gameEnterForegroundLua()
    if sceneMgr then
        sceneMgr:enterForeground()
    end
end
cc.exports.gameEnterForegroundLua   = gameEnterForegroundLua

--进入后台
local function gameEnterBackgroundLua()
    if sceneMgr then
        sceneMgr:enterBackground()
    end
end
cc.exports.gameEnterBackgroundLua   = gameEnterBackgroundLua

--lua堆栈信息
function __G__TRACKBACK__(msg)
	local msg = debug.traceback(msg, 3)
    if sceneMgr then
    	sceneMgr:errorPrint(msg)
    end

    return msg
end