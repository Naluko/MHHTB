--[[
Author: Orion
Date: 2022-04-21 09:10:22
LastEditors: Orion
LastEditTime: 2022-04-22 16:48:29
FilePath: \universal\src\DAO.lua
Description: Mysql操作工具
--]]
DAO = {}

local luasql = require 'luasql.mysql'

local database = 'mhxy' --数据库库名
local user = 'a709022263' --数据库账号
local password = 'Wwk709022263' --数据库密码
local ip = 'rm-bp1e22xef50l1o0j5qo.mysql.rds.aliyuncs.com' -- 数据库ip
local port = 3306 --端口
--创建环境
local env = luasql.mysql()
--创建连接
local conn = env:connect(database, user, password, ip, port)

--- 写入数据到数据库
---@param tableName string @表名
---@param fields string @插入字段
---@param values string @插入字段对应数据
---@return nil
function DAO.Insert(tableName,fields,values)
    local sql = "INSERT INTO mhxy."..tableName.." ("..fields..") VALUES ("..values..")"
    conn:execute(sql)
    return 1
end
--- 查询数据库
---@param fields string @查询后所需字段
---@param tableName string @表名    
---@param condition string @查询条件
---@return any @返回查询映射表
function DAO.Qurey(fields,tableName,condition)
    local sql = "SELECT "..fields.." FROM mhxy."..tableName.." WHERE "..condition
    print(sql)
    local cur = conn:execute(sql)
    return cur
end
--- 更新数据库数据
---@param tableName string @表名
---@param alterdate string @修改的数据
---@param condition string @过滤条件
---@return nil
function DAO.Update(tableName,alterdate,condition)
    local sql = "UPDATE mhxy."..tableName.." SET "..alterdate.." WHERE "..condition
    conn:execute(sql)
end
--- 删除数据库数据
---@param  tableName string @表名
---@param condition string @条件
---@return nil
function DAO.Delete(tableName,condition)
    local sql = "DELETE FROM mhxy."..tableName.." WHERE "..condition
    conn:execute(sql)
end

--- 关闭数据库连接和环境
---@return nil
function DAO.Close()
    conn:close()
    env:close()
end

return DAO
