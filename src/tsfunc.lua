---@diagnostic disable: undefined-doc-name, undefined-doc-param, missing-parameter

---
-- Author: Orion
-- Date: 2022-04-22 16:33:56
-- LastEditors: Orion
-- LastEditTime: 2022-04-24 11:46:50
-- FilePath: \universal\src\UniversalFunction.lua
-- Description: 触动精灵通用函数库
---
require('TSLib')
local class = require('middleclass')
------------------------------单点函数------------------------------

Point = class('Point')

--- 初始化点
---@param table point @格式 - {x,y,c}
---@param Point point @参考点
---@return Point @点对象
function Point:initialize(point,refer)
    if refer then
        self.x = point[1] - refer.x
        self.y = point[2] - refer.y
    else
        self.x = point[1]
        self.y = point[2]
    end
    local color = point[3]
    if color then
        if color >= 0 then
            self.condition = true
            self.color = color
        else
            self.condition = false
            self.color = -1 * color
        end
    end
end
--- 单点比色
---@param abspoint table @偏离点位坐标
---@return boolean @比色成功 - true; 比色失败 - false
function Point:IsColor(abspoint)
    local x,y,c = self.x,self.y,self.color
    if not self.color then
        return true
    else
        if abspoint then
            x = x + abspoint.x
            y = y + abspoint.y
        end
        return isColor(x,y,c) == self.condition
    end
end
--- 单点点击
---@param abspoint table @偏离点位坐标
---@return nil
function Point:click(abspoint)
    if self:IsColor() then
        local x,y = self.x,self.y
        if abspoint then
            x = x + abspoint.x
            y = y + abspoint.y
        end
       tap(x,y) 
    end
end
-- local p1 = Point({73,579,0xff9500})
-- local abspoint = Point{600,0}
-- p1:click(abspoint)
-- if p1:IsColor() then
--     nLog("12345")
-- else
--     nLog("1245")
-- end

------------------------------多点函数------------------------------
MC = class("MultiColor")
-- {N="xxxx",{x,y},{x1,y1,c1},{x2,y2,c2},R="SE"}
function MC:initialize(colors)
    self.name = colors.N
    self.points = {}
    for index, point in ipairs(colors) do
        self.points[index] = Point(point)
    end
end

-- 多点找色的封装,需要全部正确,返回true
function MC:check()
    local flag = true
    for _, point in ipairs(self.points) do
        if not point:isColor() then
            flag = false
            break
        end
    end
    return flag
end

function MC:find()
    for _, point in ipairs(self.points) do
        if point:isColor() then
            return point
        end
    end
end

function MC:findAll()
    local res = {}
    for index, point in ipairs(self.points) do
        if point:isColor() then
            res[index] = point
        end
    end
    return res
end

function MC:click()
    self.points[1]:click()
end

function MC:findInRegion(region,degree)
    degree = degree or 90
    local tmp = {}
    for index, point in ipairs(self.points) do
        if point.color then
            tmp[index] = {point.x,point.y,point.color}
        end
    end
    local x,y = findMultiColorInRegionFuzzyByTable(tmp,degree,region.x1,region.y1,region.x2,region.y2)
    if x ~= -1 then
        return Point{x,y}
    end
end


