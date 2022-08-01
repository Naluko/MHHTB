---@diagnostic disable: deprecated, missing-parameter, undefined-global
--------------------------------------------------------------------------------
--- Author: Orion
--- Date: 2022-04-25 15:50:07
--- LastEditors: Orion
--- LastEditTime: 2022-05-05 09:08:45
--- Description: 梦幻西游互通版函数
--------------------------------------------------------------------------------

require('TSLib')
require("luafunc")
local class = require('middleclass')
local charactet = require('ItemCharacteristics')

local defaultOrder = charactet.order
local itemList = charactet.gemCharcter
local bagSize = charactet.bagSize

------------------------------道具识别------------------------------

ItemRecognition = class('ItemRecognition')
--- 初始化一个ItemRecognition对象
---@param w integer@x轴间距
---@param h integer@y间距
---@param x0 integer@第一个框的x坐标
---@param y0 integer@第一个框的y坐标
---@param order table@检测物品的顺序
---@return nil @null
function ItemRecognition:initialize(w, h, x0, y0, order, item, bagsize)
    self.w = w or 130
    self.h = h or 130
    self.x0 = x0 or 100
    self.y0 = y0 or 100
    self.order = order or defaultOrder
    self.item = item or itemList
    self.bag = bagsize or bagSize
end

-- 某个单元格的物品判断,i,j是指横向第几个,纵向第几个
function ItemRecognition:checkonebag(i, j)
    keepScreen(true)
    for _, itemname in ipairs(self.order) do
        local flag = true
        for _, point in ipairs(self.item[itemname]) do
            local x1, y1, c = table.unpack(point)
            local x = x1 + self.w * (i - 1) + self.x0
            local y = y1 + self.h * (j - 1) + self.y0
            if c == 0x000000 then --背景色
                if isColor(x, y, c) then
                    flag = false
                    break
                end
            else
                if not isColor(x, y, c) then
                    flag = false
                    break
                end
            end
        end
        if flag then
            keepScreen(false)
            return itemname
        end
    end
    keepScreen(false)
    return false
end

-- 返回所有单元格的物品,未知则为false
function ItemRecognition:checkallbag()
    local imax, jmax = table.unpack(self.bag)
    local r = {}
    for i = 1, imax do
        if not r[i] then
            r[i] = {}
        end
        for j = 1, jmax do
            r[i][j] = self:checkonebag(i, j)
        end
    end
    return r
end

-- IC = ItemRecognition()
-- nLog(tostring(IC:checkonebag(1,1)))
-- local t = IC:checkallbag()
-- for index1, value in ipairs(t) do
--     for index2,v  in ipairs(value) do
--         nLog(t[index1][index2])
--         mSleep(500)
--     end
-- end


------------------------------文字识别------------------------------

OcrText = class('OcrText')
--
function OcrText:initialize()
    self.url = "http://139.224.54.233:8099/api/ocrtext/"
    self.method = "POST"
end

--- 文字识别
---@param boxlist table @值为空时，自动查找文本框。非空时，按照手动给出的文本框识别文字。格式为：[[x1,y1,x2,y2],[x3,y3,x4,y4]]，注意所包含的每一条范围（如：x1,y1,x2,y2）都只能识别单行或者单列的文字，多行是无法识别的，多行文字就标注多个范围。
---@param compress number @值为空时，默认将图片最短边压缩到960px。非空时，将最短边压缩到该值的大小。
---@param whitelist table @只返回白名单字符串中包含的字符。
---@param colorlist table @给出多组颜色，相近的颜色为一个列表，预处理后才进行识别。格式为：[["0x000000","0x000001"],["0x111110","0x111111"]]，每个元素是一个字符串，内容是一个16进制的RGB颜色信息。
---@param is_draw boolean @是否返回，画出文字区域的图片base64值
---@return string @识别到的字符串
function OcrText:run(boxlist, flag, compress, whitelist, colorlist, is_draw)
    local sz = require("sz")
    local img_path = userPath() .. '/res/ocr_text/'
    local ts = require("ts")
    local json = ts.json
    local time = ts.ms() * 10000
    img_path = img_path .. time .. ".png"
    os.execute("rm -rf "..userPath()..'/res/ocr_text/*')
    snapshot(img_path)
    local http_socket = require('szocket.http')
    local response_body = {}
    local post_data = {}
    local date = self:contentfill(boxlist, img_path, compress, whitelist, colorlist, is_draw, post_data)
    local res, code = http_socket.request {
        url = self.url,
        method = self.method,
        headers = self.header,
        source = ltn12.source.string(date),
        sink = ltn12.sink.table(response_body)
    }
    if code == 200 then
        
        local str = response_body[1]
        nLog(str)
        -- nLog(str)
        if #str > 0 then
            local words = json.decode(str)["words"]
            if words then
                local str = ""
                for key, value in ipairs(words) do
                    if key == 1 then 
                        str = words[key][1]
                    else
                        str = str .. "----" .. words[key][1]
                    end
                end
                return str
            else
                return "识别失败"
            end
        end
    else
        return "识别失败"
    end
end

function OcrText:contentfill(boxlist, img_path, compress, whitelist, colorlist, is_draw, post_data)
    local ts = require("ts")
    local json = ts.json
    local imgfile = io.readJPEG(img_path)
    if boxlist ~= nil then
        post_data[1] = string.format('----abcdefg\r\nContent-Disposition: form-data; name="boxlist"\r\n\r\n%s\r\n', json.encode(boxlist))
    end
    if type(compress) == "number" then
        post_data[#post_data + 1] = string.format('----abcdefg\r\nContent-Disposition: form-data; name="compress"\r\n\r\n%s\r\n', compress)
    end
    if type(whitelist) == "table" then
        post_data[#post_data + 1] = string.format('----abcdefg\r\nContent-Disposition: form-data; name="whitelist"\r\n\r\n%s\r\n', json.encode(whitelist))
    end
    if type(colorlist) == "table" then
        post_data[#post_data + 1] = string.format('----abcdefg\r\nContent-Disposition: form-data; name="colorlist"\r\n\r\n%s\r\n', json.encode(colorlist))
    end
    if type(is_draw) == "boolean" then
        post_data[#post_data + 1] = string.format('----abcdefg\r\nContent-Disposition: form-data; name="isdraw"\r\n\r\n%s\r\n', tostring(is_draw))
    end
    post_data[#post_data + 1] = string.format('----abcdefg\r\nContent-Disposition: form-data; name="file"; filename="push.png"\r\nContent-Type: image/png\r\n\r\n%s\r\n----abcdefg--', imgfile)
    post_data = table.concat(post_data)
    -- nLog(post_data)
    self.header = {
        ["Content-Type"] = 'multipart/form-data; boundary=--abcdefg',
        ["Content-Length"] = #post_data,
    }
    return post_data
end

local ocr = OcrText()
local box = {{85,222,233,269}}
local img_path = "I:\\VsCodeWorkSpace\\mh\\PIC_1650866992054.png"
local whitelist = { "登", "录", "i", "P", "h", "o", "n", "e" }
local colorlist = { { "0x007aff" } }
local t = ocr:run(box)
nLog(t)
-- for key, value in pairs(t) do
--     print(type(key))
--     print(type(value))
--     print(key..".."..value)
-- end
