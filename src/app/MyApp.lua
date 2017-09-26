local MyApp                         = class("MyApp")

function MyApp:ctor()
end

function MyApp:run()
    local director                  = cc.Director:getInstance()
    --游戏窗口大小
    local winSize                   = director:getVisibleSize()
    cc.exports.Screen_Width         = winSize.width
    cc.exports.Screen_Height        = winSize.height

    if CC_SHOW_FPS then
        director:setDisplayStats(true)
    else
        director:setDisplayStats(false)
    end
    
    local scene 				    = cc.Scene:create()
    display.runScene(scene)
    
    --启动更新UI
    local updateLay                 = require('app.views.UpdateUI').new(scene)
    scene:addChild(updateLay)
end

return MyApp
