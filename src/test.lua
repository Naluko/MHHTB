--------------------------------------------------------------------------------
--- Author: Orion
--- Date: 2022-04-21 15:54:22
--- LastEditors: Orion
--- LastEditTime: 2022-05-04 20:30:56
--- FilePath: \src\test.lua
--- Description:
--------------------------------------------------------------------------------
-- local imgfile
-- local file = io.open('I:\\VsCodeWorkSpace\\mh\\PIC_1650866992054.png', 'rb')
-- if file then
--     imgfile = file:read('*a')
--     file:close()
-- end
-- str = string.format('----abcdefg\r\nContent-Disposition: form-data; name="file"; filename="push.jpg"\r\nContent-Type: image/jpeg\r\n\r\n%s\r\n----abcdefg--',imgfile)

-- local table1 = {1,2,3,4,5,6,7,8,9,10}
-- print(table.concat(table1))

-- -- local ts = require("ts")--使用扩展库前必须插入这一句
-- local json = ts.json--使用 JSON 模块前必须插入这一句
-- local tb = {
--     ["我"] = "五毛",
--     ["爱"] = "六块",
--     meme = {
--         isArray = true,
--         1,0,0,4,6,9,5,1,0,0,
--     },
--     nullvalue = null,
-- }
-- --把 table 转换成 json 字符串


-- function TableToStr(t)
--     if t == nil then return "" end
--     local retstr= "{"
--     local i = 1
--     for key,value in pairs(t) do
--         local signal = ","
--         if i==1 then
--           signal = ""
--         end

--         if key == i then
--             retstr = retstr..signal..ToStringEx(value)
--         else
--             if type(key)=='number' or type(key) == 'string' then
--                 retstr = retstr..signal..'['..ToStringEx(key).."]="..ToStringEx(value)
--             else
--                 if type(key)=='userdata' then
--                     retstr = retstr..signal.."*s"..TableToStr(getmetatable(key)).."*e".."="..ToStringEx(value)
--                 else
--                     retstr = retstr..signal..key.."="..ToStringEx(value)
--                 end
--             end
--         end

--         i = i+1
--     end

--      retstr = retstr.."}"
--      return retstr
-- end

-- local t = "[111,12,23,45]"
-- local t1 = {111,12,23,45}

-- local str = TableToStr(t1)

-- print(str)

-- local json = string.format('----abcdefg\r\nContent-Disposition: form-data; name="boxlist"\r\n\r\n%s\r\n',"["..t.."]")
-- print(json)

-- function ToStringEx(value)
--     if type(value)=='table' then
--        return TableToStr(value)
--     elseif type(value)=='string' then
--         return "\'"..value.."\'"
--     else
--        return tostring(value)
--     end
-- end

-- function StrToTable(str)
--     if str == nil or type(str) ~= "string" then
--         return
--     end

--     return loadstring("return " .. str)()
-- end

-- function TableToStr(t)
--     if t == nil then return "" end
--     local retstr= "{"

--     local i = 1
--     for key,value in pairs(t) do
--         local signal = ","
--         if i==1 then
--           signal = ""
--         end

--         if key == i then
--             retstr = retstr..signal..ToStringEx(value)
--         else
--             if type(key)=='number' or type(key) == 'string' then
--                 retstr = retstr..signal..'['..ToStringEx(key).."]="..ToStringEx(value)
--             else
--                 if type(key)=='userdata' then
--                     retstr = retstr..signal.."*s"..TableToStr(getmetatable(key)).."*e".."="..ToStringEx(value)
--                 else
--                     retstr = retstr..signal..key.."="..ToStringEx(value)
--                 end
--             end
--         end

--         i = i+1
--     end

--      retstr = retstr.."}"
--      return retstr
-- end

-- local tb = {
--     [1] = "A";
--     [2] = "B";
--     [3] = "C";
--     [4] = "D";
-- }

-- -- 表转字符串
-- local strtb = TableToStr(tb)
-- print(strtb)

-- -- 字符串转表
-- local newtb = StrToTable(strtb)
-- for k,v in ipairs(newtb) do
--         print(k,v)
-- end

-- local DumpData = require("DumpData")
-- local str = "123knk"
-- local t = {"1","2","3","4",N = "1234567789",{"我","是"}}
-- print(DumpData(str))

-- print(DumpData(t))

-- local ts = require("ts")

-- local  header_send = {typeget = "ios"}
-- local body_send = {msg = "hello"}

-- local ts = require("ts")
-- require("luafunc")
-- file = io.readJPEG(userPath .. '/res/PIC_1650866992054.png')
-- header_send = { ["Content-Type"] = 'multipart/form-data; boundary=--abcdefg',
--     ["Content-Length"] = #post_data, }
-- body_send = {

--     ["file"] = file
-- }

-- status_resp, header_resp, body_resp = ts.httpPost("http://api.qingyunke.com/api.php?msg=123&key=free", header_send, body_send, true)
-- dialog(status_resp, 0)
-- dialog(header_resp, 0)
-- dialog(body_resp, 0)


-- require("tsnet")
-- require("TSLib")
-- require("luafunc")
-- local url = "http://139.224.54.233:8099/api/ocrtext/"
-- path = userPath();
-- local imgfile = io.readJPEG(path .. '/res/PIC_1650866992054.png')
-- local post_data = string.format('----abcdefg\r\nContent-Disposition: form-data; name="file"; filename="push.png"\r\nContent-Type: image/png\r\n\r\n%s\r\n----abcdefg--', imgfile)

-- local header_send = {
--     ["Content-Type"] = 'multipart/form-data; boundary=--abcdefg',
--     ["Content-Length"] = #post_data
-- }
-- status,header,content = http.post(url,{headers=header_send,postdata = post_data})
-- if status == 200 then
--     toast("成功",5)
--     dialog(header,6)
--     dialog(content,6)
--     else..


--     dialog("失败")
-- end

require("TSLib")
nLog("123248")
