--UI基类
local UIBase = class("UIBase", function ()
    return cc.Layer:create()
end)

function UIBase:ctor(sTag, ...) 
    local param1, param2, param3 = ...
    local resName = UIMgr.configs[sTag].resName
    if resName then
        --todo: load moduel pack res
    end

	local function onEventHandler(eventType)
        if eventType == "enter" then
            self:onEnter(param1, param2, param3)
        elseif eventType == "exit" then
            if resName then
                display.removeSpriteFrames(string.format('ui/%s.plist', resName))
            end
            self:onExit(param1, param2, param3)
        end
    end
    self:registerScriptHandler(onEventHandler) 

    self:init(...)
    self:_loadCsbUI(sTag, self.widget)
end

--加载类对象绑定的csb
function UIBase:_loadCsbUI(sTag, widget)
    local csbName = "csb/" .. UIMgr.configs[sTag].moduleName .. ".csb"
    local csb = cc.CSLoader:createNodeWithVisibleSize(csbName)
    self:addChild(csb)

    if type(widget) ~= 'table' then
        return
    end

    for i,v in ipairs(widget) do
        self[v[1]] = UIMgr:seekWidgetByNameEx(csb, v[1])
        if not self[v[1]] then
            printError(v[1] .. ':widget no exist in' .. moduleName)
        end

        if self[v[2]] then
            self[v[1]]:setTouchEnabled(true)
            self[v[1]]:addTouchEventListener(function(sender,event)
                if event == ccui.TouchEventType.ended then
                    self[v[2]](self, sender, event)
                end
            end)
        end
    end
end

return UIBase