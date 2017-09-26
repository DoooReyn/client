--[[
说明：
1，类名和对应UIcsb名约定一致，统一用字段moduleName
2，resName为对应打包plist文件名(即资源目录名，同时资源命名需以目录名为前缀)
3，UIMgr创建UI必须统一调用UIMgr:releaseUI(sTag)来释放，清除引用
]]

local UIMgr             = {}

-----------------------------UI配置--------------------------------
UIMgr.configs           = {
    login               = {moduleName = "LoginUI"},
}

--保存当前已加载的所有类对象UI
local SaveObjArr = {}

--重置忽略UI
local ResetIgnore = {
    main                = true,
    chat                = true,
}


-----------------------------公共接口-------------------------------
--[[
加载UI
@param sTag  标号
@param ...   附加参数
]]
function UIMgr:loadObjUI(sTag, ...)
    if SaveObjArr[sTag] then
        printInfo(sTag .. ":ui is loaded!")
        return
    end

    local parentLay = sceneMgr.uiLayer
    local className = "app.views." .. UIMgr.configs[sTag].moduleName
    local objNode = require(className):create(sTag, ...)
    parentLay:addChild(objNode)
    SaveObjArr[sTag] = objNode
end

--关闭UI   @param sTag  标号 
function UIMgr:releaseUI(sTag)
    if SaveObjArr[sTag] then
        SaveObjArr[sTag]:removeFromParent()
        SaveObjArr[sTag] = nil
    else
        printInfo(sTag .. ":ui is released!")
    end
end

--重置UI
function UIMgr:resetUI()
    for k,v in pairs(SaveObjArr) do
        if not ResetIgnore[k] then
            v:removeFromParent()
            SaveObjArr[k] = nil
        end
    end
end

--切换UI @param sTag  标号 @param ...  额外参数
function UIMgr:switchUI(sTag, ...)
    self:resetUI()
    self:loadObjUI(sTag, ...)
end

--退出UI
function UIMgr:exitUI()
    for k,v in pairs(SaveObjArr) do
        v:removeFromParent()
        SaveObjArr[k] = nil
    end
    sceneMgr.uiLayer:removeAllChildren()     
    SaveObjArr = {}
end

--获得某UI对象 @param sTag  标号
function UIMgr:getObj(sTag)
    return SaveObjArr[sTag]
end

--加载基类
function UIMgr:loadBase(module)
    return require("app.views." .. module)
end

--递归遍历子节点
function UIMgr:seekWidgetByNameEx(root, name)
    local rootArr = root:getChildren()
    if rootArr then
        for i,v in ipairs(rootArr) do
            if v:getName() == name then
                return v
            end
            local res = self:seekWidgetByNameEx(v, name)
            if res then
                return res
            end
        end
    end
    
    return nil 
end

return UIMgr