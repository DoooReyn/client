local Util 					    = class("Util")

function Util:ctor()
end

--------------------------------分包下载开始------------------------------
--初始化分包信息
function Util:initExtendResInfo()
    self.extendResInfo          = {}
    local instance              = cc.UserDefault:getInstance()
    local targetPlatform        = cc.Application:getInstance():getTargetPlatform()

    for i,v in ipairs(downloadResList) do
        local key1              = v .. '_isDownload'
        local key2              = v .. '_percent'
        local info              = {}

        info.isDownload         = instance:getBoolForKey(key1, false)
        info.percent            = instance:getIntegerForKey(key2)
        if info.isDownload then
            info.percent        = 100
        elseif targetPlatform == cc.PLATFORM_OS_WINDOWS then
        elseif targetPlatform == cc.PLATFORM_OS_ANDROID then
        else
            info.percent        = 0
        end
        
        table.insert(self.extendResInfo, info)
    end
end

--设置分包信息
function Util:setExtendResInfo(customId, percent)
    if not self.extendResInfo then
        return
    end
    
    local instance              = cc.UserDefault:getInstance()
    local targetPlatform        = cc.Application:getInstance():getTargetPlatform()
    local idx                   = tonumber(string.sub(customId, -2))
    local info                  = self.extendResInfo[idx]
    if not info then
        return
    end

    local name                  = downloadResList[idx]
    local key1                  = name .. '_isDownload'
    local key2                  = name .. '_percent'

    if percent then
        info.percent            = percent
    else
        info.isDownload         = true
        info.percent            = 100
        instance:setBoolForKey(key1, true)
    end

    if targetPlatform == cc.PLATFORM_OS_WINDOWS then
        instance:setIntegerForKey(key2, info.percent)
    elseif targetPlatform == cc.PLATFORM_OS_ANDROID then
        instance:setIntegerForKey(key2, info.percent)
    end
end

function Util:downloadExtendRes(resList)
    for i,v in ipairs(resList) do
        local info                  = self.extendResInfo[v]
        local name                  = downloadResList[v]
        if info and not info.isDownload then
            downloadExtendRes(name, v)
        end
    end
end

function Util:noticeDownloadRes()
    local isNotice                  = false
    for i,v in ipairs(self.extendResInfo) do
        if not v.isDownload then
            isNotice                = true
            break
        end
    end

    if not isNotice then
        return
    end

    ----特殊推送的添加推送福利下载页面
    dataMgr.BaseData:addOneActivitySend(98)
    publicNotice:sendActivityNotice()
end
--------------------------------分包下载结束------------------------------


--世界坐标某点是否在节点内
function Util:isWorldPosInNode(node,pos)
    if not node then
        return
    end
    local pos = node:convertToNodeSpace(pos)
    local size = node:getContentSize()
    return cc.rectContainsPoint(cc.rect(0,0,size.width,size.height),pos)
end

--屏蔽节点下层(frame:点击frame之外释放csb)
function Util:registerScriptMask(csb,frame)
    local function onTouchBegan(touch, event)
        return true
    end

    local function onTouchEnded(touch, event)
        if not frame then
            return
        end
        local pos = touch:getStartLocation()
        if not self:isWorldPosInNode(frame,pos) then
            csb:removeFromParent()
            csb = nil
        end
    end

    local listener = cc.EventListenerTouchOneByOne:create()
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
    listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
    local eventDispatcher = csb:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, csb)
end

return Util
