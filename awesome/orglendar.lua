-- Calendar with Emacs org-mode agenda for Awesome WM
-- Inspired by and contributed from the org-awesome module, copyright of Damien Leone
-- Licensed under GPLv2
-- Version 1.0-awesome-git
-- @author Alexander Yakushev <yakushev.alex@gmail.com>

local pairs = pairs
local ipairs = ipairs
local io = io
local os = os
local math = math
local tonumber = tonumber
local string = string
local table = table
local awful = require("awful")
local util = awful.util
local theme = require("beautiful")
local naughty = require("naughty")
local print = print

module("orglendar")

files = {}
char_width_9 = 7.3
char_width_8 = 6.3
text_color = "#dddddd"
today_color = "#30d121"
event_color = "#5EA9DB"
today_event_color = "#ff0000"
-- text_color = "#FFFFFF"
-- today_color = "#00FF00"
-- event_color = "#FF0000"
cal_font = 'monospace 9'
todo_font = 'monospace 8'
parse_on_show = true
calendar_width = 21
limit_todo_length = nil

local calendar = nil
local todo = nil
local offset = 0

local data = nil

local function pop_spaces(s1, s2, maxsize)
   local sps = ""
   for i = 1, maxsize - string.len(s1) - string.len(s2) do
      sps = sps .. " "
   end
   return s1 .. sps .. s2
end

function parse_agenda()
   local today = os.date("%Y-%m-%d")
   data = { tasks = {}, dates = {}, maxlen = 20 }

   local task_project
   for _, file in pairs(files) do
      local fd = io.open(file, "r")
      if not fd then
         print("W: orglendar: cannot find " .. file)
      else
         for line in fd:lines() do
            if string.find(line, "^(%a+):") then
               _, _, task_project = string.find(line, "^(%a+):")
            else
               if not string.find(line, "@done") then
                  if string.find(line, "@d%(") then
                     local _, _, y, m, d  = string.find(line, "@d%((%d%d%d%d)%-(%d%d)%-(%d%d)")
                     local task_date = y .. "-"  .. m .. "-" .. d

                     if task_project == nil then
                         task_project = "None"
                     end
                     if d and (task_date >= today) then
                        local _, _, task_name = string.find(line, "%s+%-(.-)[@$]")

                        if task_name == nil then
                            task_name = "Go fuck yourself"
                        end
                        local len = string.len(task_name) + string.len(task_project)
                        if (len > data.maxlen) and (task_date >= today) then
                           data.maxlen = len
                        end
                        table.insert(data.tasks, { name = task_name,
                                                   tags = task_project,
                                                   date = task_date})
                        data.dates[y .. tonumber(m) .. tonumber(d)] = true
                     end
                  end
                  if string.find(line, "@today") then
                     if task_project == nil then
                         task_project = "None"
                     end
                     local _, _, task_name = string.find(line, "%s+%-(.-)[@$]")
                     if task_name == nil then
                         task_name = "Go fuck yourself"
                     end
                     local len = string.len(task_name) + string.len(task_project)
                     if (len > data.maxlen) then
                         data.maxlen = len
                     end
                     table.insert(data.tasks, { name = task_name,
                                                tags = task_project,
                                                date = today})
                     data.dates[os.date("%Y%m%d")] = true
                end
              end
            end
         end
      end
   end
   table.sort(data.tasks, function (a, b) return a.date < b.date end)
end

local function create_calendar()
   offset = offset or 0

   local now = os.date("*t")
   local cal_month = now.month + offset
   local cal_year = now.year
   if cal_month > 12 then
      cal_month = (cal_month % 12)
      cal_year = cal_year + 1
   elseif cal_month < 1 then
      cal_month = (cal_month + 12)
      cal_year = cal_year - 1
   end

   local last_day = os.date("%d", os.time({ day = 1, year = cal_year,
                                            month = cal_month + 1}) - 86400)
   local first_day = os.time({ day = 1, month = cal_month, year = cal_year})
   local first_day_in_week =
      os.date("%w", first_day)
   local result = "Su Mo Tu We Th Fr Sa\n"
   for i = 1, first_day_in_week do
      result = result .. "   "
   end

   local this_month = false
   for day = 1, last_day do
      local last_in_week = (day + first_day_in_week) % 7 == 0
      local day_str = pop_spaces("", day, 2) .. (last_in_week and "" or " ")

      if cal_month == now.month and cal_year == now.year and day == now.day then
         this_month = true
         if data.dates[cal_year .. cal_month .. day] then
            result = result ..
               string.format('<span weight="bold" foreground = "%s">%s</span>',
                             today_event_color, day_str)
         else
            result = result ..
               string.format('<span weight="bold" foreground = "%s">%s</span>',
                             today_color, day_str)
         end
      elseif data.dates[cal_year .. cal_month .. day] then
         result = result ..
            string.format('<span weight="bold" foreground = "%s">%s</span>',
                          event_color, day_str)
      else
         result = result .. day_str
      end

      if last_in_week and day ~= last_day then
         result = result .. "\n"
      end
   end

   local header
   if this_month then
      header = os.date("%a, %d %b %Y")
   else
      header = os.date("%B %Y", first_day)
   end
   return header, string.format('<span font="%s" foreground="%s">%s</span>',
                                cal_font, text_color, result)
end

function add_calendar()
   offset = offset or 0
   local datespec = os.date("*t")
   datespec = datespec.year * 12 + datespec.month - 1 + offset
   datespec = (datespec % 12 + 1) .. " " .. math.floor(datespec / 12)
   local cal = awful.util.pread("cal " .. datespec)
   cal = string.gsub(cal, "^%s*(.-)%s*$", "%1")

   local header
   if this_month then
      header = os.date("%a, %d %b %Y")
   else
      header = os.date("%B %Y", first_day)
   end

   return header, string.format('<span font_desc="%s">%s</span>span>', "monospace", os.date("%a, %d ") .. cal)
end

local function create_todo()
   local result = ""
   local maxlen = data.maxlen + 3
   if limit_todo_length and limit_todo_length < maxlen then
      maxlen = limit_todo_length
   end
   local prev_date, limit, tname
   for i, task in ipairs(data.tasks) do
      if prev_date ~= task.date then
         result = result ..
            string.format('<span weight = "bold" foreground = "%s">%s</span>\n',
                          event_color,
                          pop_spaces("", task.date, maxlen))
      end
      tname = task.name
      limit = maxlen - string.len(task.tags) - 3
      if limit < string.len(tname) then
         tname = string.sub(tname, 1, limit - 3) .. "..."
      end
      result = result .. pop_spaces(tname, task.tags, maxlen)

      if i ~= #data.tasks then -- is obsolete: table.getn(data.tasks) then
         result = result .. "\n"
      end
      prev_date = task.date
   end
   if result == "" then
      result = " "
   end
   return string.format('<span font="%s" foreground="%s">%s</span>',
                        todo_font, text_color, result), data.maxlen + 3
end

function get_calendar_and_todo_text(_offset)
   if not data or parse_on_show then
      parse_agenda()
   end

   offset = _offset
   local header, cal = create_calendar()
   return string.format('<span font="%s" foreground="%s">%s</span>\n%s',
                        cal_font, text_color, header, cal), create_todo()
end

local function calculate_char_width()
   -- return theme.beautiful.get_font_height(font) * 0.555
   return 8 * 0.555
end

function hide()
   if calendar ~= nil then
      naughty.destroy(calendar)
      calendar = nil
      offset = 0
   end
   if todo ~= nil then
      naughty.destroy(todo)
      todo = nil
  end
end

function show(inc_offset)
   inc_offset = inc_offset or 0

   if not data or parse_on_show then
      parse_agenda()
   end

   local save_offset = offset
   hide()
   offset = save_offset + inc_offset

   local header, cal_text = create_calendar()
   calendar = naughty.notify({ title = header,
                               text = cal_text,
                               timeout = 0, hover_timeout = 0.5,
                               width = calendar_width * char_width_9,
                               position = "bottom_right",
                            })
   todo = naughty.notify({ title = "TO-DO list",
                           text = create_todo(),
                           timeout = 0, hover_timeout = 0.5,
                           width = (data.maxlen + 3) * char_width_8,
                           position = "bottom_right",
                        })
end

function edit_todo()
    for _, file in pairs(files) do
        awful.util.spawn('urxvt -e vim ' .. file)
    end
end

function register(widget)
   widget:add_signal("mouse::enter", function() show(0) end)
   widget:add_signal("mouse::leave", hide)
   widget:buttons(util.table.join( awful.button({ }, 3, function()
                                                           -- parse_agenda()
                                                           edit_todo()
                                                        end),
                                   awful.button({ }, 4, function()
                                                           show(-1)
                                                        end),
                                   awful.button({ }, 5, function()
                                                           show(1)
                                                        end)))
end
