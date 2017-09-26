local MessageFactory 						= class("MessageFactory")

--key消息名字 value为{主消息号 子消息号}
-------------------------消息映射-------------------------
local msgMap 								= {
}


function MessageFactory:ctor()
	self.mainCmd        					= {}
end

--设置主消息号
function MessageFactory:setMainMsg(msg)
	for _,v in ipairs(msg) do
		local arr 			= string.split(v.name, "_")
		local key 			= arr[2]
		self.mainCmd[key] 	= v.number
	end

	--添加平台主消息号
	self.mainCmd["Null"]	= 0
	self.mainCmd["Login"]	= 250
	self.mainCmd["Chat"]	= 253
end

--重置主消息号
function MessageFactory:resetMainMsg()
	self.mainCmd 							= nil
end

--注册消息号
function MessageFactory:register(data, fileName)
	--注册主消息号
	if fileName == "Cmd" then
		for _,v in ipairs(data.enum_type) do
			if v.name == "ClientCommand" then
				self:setMainMsg(v.value)
				break
			end 
		end
		return
	end
    
    ---------------------消息映射---------------------
	local pkg 					= data.package
	--暂且定义消息名==文件名（这样不用遍历主消息循环）
	local msgName 				= fileName
	if fileName == "nullcommand" then
		msgName 				= "Null"
	elseif fileName == "logincommand" then
		msgName 				= "Login"
	elseif fileName == "chatcommand" then
		msgName 				= "Chat"
	end
    
    --获取主消息
    local byCmd 				= self.mainCmd[msgName]
    if not byCmd then
    	printInfo("%s::main msg is null", msgName)
    	return
    end

	for _,v in ipairs(data.message_type) do
		if v.name == msgName then
			self:regMsg(v.enum_type,byCmd,pkg)
			break
		end
    end
end

--注册一条消息
function MessageFactory:addOneMsg(name, byCmd, byParam)
	local value 							= {}
	value.byCmd 							= byCmd
	value.byParam 							= byParam
	msgMap[name]                            = value
	
	--打印
	--dump(value, name)
end

--映射消息号
function MessageFactory:regMsg(msg, byCmd, pkg)
	print(pkg)
	if pkg ~= "Pmd" and pkg ~= "GameCmd" then
		printError("pkg name is error")
		return
	end
	for _,v in ipairs(msg) do
		if v.name == "Param" then
			for _,v in ipairs(v.value) do
				local name = pkg .. "." .. v.name
				self:addOneMsg(name,byCmd,v.number)
            end
            break
		end
	end
end

-----------------------------外部接口-----------------------------
--通过值获取名字
function MessageFactory:getName(byCmd, byParam)
	for k,v in pairs(msgMap) do
		if byCmd == v.byCmd and byParam == v.byParam then
			return k
		end
	end
	return nil
end

--通过名字获取值（{主消息，子消息}）
function MessageFactory:getValue(name)
	local value 							= nil
	value                                   = msgMap[name]
    return value
end

return MessageFactory
