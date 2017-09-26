local SceneMgr 				        = class("SceneMgr")

local z_map                         = 1     --地图层
local z_joy                         = 2     --遥感
local z_eft                         = 3     --寻路和自动战斗效果
local z_msg                         = 4     --消息提示
local z_ui                          = 5     --UI层
local z_broad                       = 6     --提示板
local z_tip                         = 7     --tip
local z_load                        = 20    --网络cd
local z_log                         = 100   --错误日志

function SceneMgr:ctor()
end

function SceneMgr:init(scene)
    scene:removeAllChildren()
    self.scene                      = scene

    self:loadGlobalLua()
    self:registerData()
    self:loadProto()
    self:addChildWidgets()
    util:initExtendResInfo()
    configMgr:load()

    UIMgr:loadObjUI("login")
end

--加载全局lua文件
function SceneMgr:loadGlobalLua()
    --base
    require "app.base.protobuf"
    require "app.base.XmlParse"
    cc.exports.md5                  = require("app.base.md5")

    --net
    cc.exports.net                  = require("app.net.Net").new()
    cc.exports.messageFactory       = require("app.net.MessageFactory").new()
    cc.exports.eventHandler         = require("app.net.EventHandler").new()

    --mgr
    cc.exports.dataMgr              = require("app.manager.DataMgr")
    cc.exports.configMgr            = require("app.manager.ConfigMgr")
    cc.exports.UIMgr                = require("app.manager.UIMgr")
    cc.exports.soundMgr             = require("app.manager.SoundMgr").new()
    cc.exports.resMgr               = require("app.manager.ResMgr").new()

    --util
    cc.exports.util                 = require("app.utils.Util").new()
    cc.exports.Macro                = require("app.utils.Macro")
end

--注册data
function SceneMgr:registerData()
    for _,v in pairs(dataMgr) do
        if v.ctor then
            --初始化
            v:ctor()
        end

        if v.addEvent then
            --注册
            v:addEvent()
            for k,v in pairs(v.msgList) do
                addEventLua(k, v)
            end
        end
    end
end

--加载proto文件
function SceneMgr:loadProto()
    local proTab                    = {
        --主消息
        "Cmd",
        --pmd
        "nullcommand",
        "logincommand",
        "chatcommand",
        --cmd
        "LogonUserCmd",
    }

    local fileUtils                 = cc.FileUtils:getInstance()
    for k,v in pairs(proTab) do
        local pbFilePath            = "proto/" .. v .. ".pb"
        local fullpath = fileUtils:fullPathForFilename(pbFilePath)
        local buffer                = bsReadFile(fullpath)
        protobuf.register(buffer)

        local protoData             = protobuf.decode("google.protobuf.FileDescriptorSet", buffer)
        messageFactory:register(protoData.file[1], v)
    end
    messageFactory:resetMainMsg()
end

--添加场景全局子节点
function SceneMgr:addChildWidgets()
    --UI层
    self.uiLayer                    = cc.Node:create()
    self.scene:addChild(self.uiLayer, z_ui)

    --提示层
    self.tipLayer                   = cc.Node:create()
    self.scene:addChild(self.tipLayer, z_tip)
end


----------------------------游戏其它处理-----------------------------
--打印日志
function SceneMgr:errorPrint(msg)
    if type(DEBUG) ~= "number" or DEBUG < 2 then
        return 
    end
    
    print(msg)

    --在屏幕打印错误信息
    cc.Director:getInstance():pause()
    if not self.logLab then
        self.logLab = ccui.Text:create(msg,"",20)
        self.scene:addChild(self.logLab, z_log)
        self.logLab:setTextColor(cc.c4b(255, 0, 0, 255))
        self.logLab:setPosition(Screen_Width / 2 - 10, 100)
    else
        self.logLab:setString(msg)
    end
end

function SceneMgr:enterForeground(msg)
    printInfo("游戏进入前台------")
    if net then
        net:enterForeground()
    end

    if soundMgr then
        soundMgr:playMusic(soundMgr.musicName)
    end
end

function SceneMgr:enterBackground(msg)
    printInfo("游戏进入后台------")
    if soundMgr then
        soundMgr:stopMusic(true)
    end
end

return SceneMgr
