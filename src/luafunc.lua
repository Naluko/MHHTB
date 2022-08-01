--------------------------------------------------------------------------------
--- Author: Orion
--- Date: 2022-04-25 15:45:55
--- LastEditors: Orion
--- LastEditTime: 2022-04-27 16:30:21
--- Description: LUA通用函数库
--------------------------------------------------------------------------------





------------------------------表相关函数------------------------------

--- 检测表是否包含某个元素
---@param  table table @表
---@param element any @目标元素
---@return boolean @包含 - true; 不包含 - false
function table.contains(table, element)
    if table == nil then
        return false
    end

    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

--- 表长度计算
---@param  table table @表
---@return integer @表长度
--table长度计算
function table.count(table)
    local count = 0

    for k, v in pairs(table) do
        count = count + 1
    end

    return count
end

--- 合并两个数组
---@param sourceTable table @主表
---@param addTable table @副表
---@return nil
function table.addRange(sourceTable, addTable)
    for k, v in pairs(addTable) do
        table.insert(sourceTable, v)
    end
end

--- 合并两个表
---@param  sourceTable table @主表
---@param addTable table @副表
---@return nil
function table.merge(sourceTable, addTable)
    for k, v in pairs(addTable) do
        sourceTable[k] = v
    end
end

--- 复制一个表到一个空表
---@param st table @需要复制的表
---@return table @复制后的表
function table.copy(st)
    local tab = {}
    for k, v in pairs(st or {}) do
        if type(v) ~= "table" then
            tab[k] = v
        else
            tab[k] = table.copy(v)
        end
    end
    return tab
end

--- 复制源表到另一个表
---@param source table @源表
---@param des table @目标表
---@return nil
function table.copyTo(source, des)
    local tab = des
    for k, v in pairs(source or {}) do
        if type(v) ~= "table" then
            tab[k] = v
        else
            tab[k] = table.copy(v)
        end
    end
end

--- 查询目标值在数组中的索引
---@param list table @数组
---@param target any @目标值
---@param from integer @起始索引
---@param useMaxN integer @数组最大索引值
---@return integer @找到目标 - 目标index; 未找到目标 - -1
function table.indexOf(list, target, from, useMaxN)
    local len = (useMaxN and #list) or table.maxn(list)
    if from == nil then
        from = 1
    end
    for i = from, len do
        if list[i] == target then
            return i
        end
    end
    return -1
end

--- 反转数组
---@param t table @需要反转的数组
---@return nil
function table.reverse(t)
    local l = #t
    local c = math.floor(l / 2)
    for i = 1, c do
        local v = t[i]
        t[i] = t[l - i + 1]
        t[l - i + 1] = v
    end
end

--- 表映射
---@param  t table @表
---@param fun function @函数
---@return table @映射关系表
function table.map(t, fun)
    local l = {}
    for k, v in pairs(t) do
        l[k] = fun(v, k)
    end
    return l
end

--- 表过滤
---@param  t table @表
---@param fun function @过滤函数
---@return table @过滤后的表
function table.select(t, fun)
    local l = {}
    for k, v in pairs(t) do
        if fun(v, k) then
            l[k] = v
        end
    end
    return l
end

--- 读取图片为二进制文件
---@param img_path string @图片路径
---@return nil @二进制文件
function io.readJPEG(img_path)
    -- nLog(img_path)
    local imgfile
    local file = io.open(img_path, 'rb')
    if file then
        imgfile = file:read('*a')
        file:close()
        return imgfile
    else
        nLog("没有读取到文件")
        return 
    end
end