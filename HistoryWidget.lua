
local XpTimer = _G.XpTimer

local AceGUI = LibStub("AceGUI-3.0")

local SCALE_LENGTH = 10

--XpTimer.db.profile.History = {{["time"]=123211,["place"]="feilasi"},{["time"]=123233,["place"]="jiajisen"}}


--local test_array = XpTimer.db.profile.History
--local an = table.getn(test_array)
--
--for i= 1, an do
--    DEFAULT_CHAT_FRAME:AddMessage(test_array[i])
--end



function XpTimer:GetHisRow(data)
    local title_group = AceGUI:Create("SimpleGroup")
    title_group:SetLayout("Flow")
    title_group:SetWidth(floor(86*SCALE_LENGTH))

    local time_label = AceGUI:Create("Label")
    time_label:SetText(data["time"])
    time_label:SetWidth(16*SCALE_LENGTH)
    title_group:AddChild(time_label)

    local place_label = AceGUI:Create("Label")
    place_label:SetText(data["place"])
    place_label:SetWidth(10*SCALE_LENGTH)
    title_group:AddChild(place_label)

    local time_long_label = AceGUI:Create("Label")
    time_long_label:SetText(data["time_long"])
    time_long_label:SetWidth(8*SCALE_LENGTH)
    title_group:AddChild(time_long_label)

    local level_label = AceGUI:Create("Label")
    level_label:SetText(data["level"])
    level_label:SetWidth(6*SCALE_LENGTH)
    title_group:AddChild(level_label)

    local exp_label = AceGUI:Create("Label")
    exp_label:SetText(data["exp"])
    exp_label:SetWidth(8*SCALE_LENGTH)
    title_group:AddChild(exp_label)

    local kill_num_label = AceGUI:Create("Label")
    kill_num_label:SetText(data["kill_num"])
    kill_num_label:SetWidth(8*SCALE_LENGTH)
    title_group:AddChild(kill_num_label)

    local exp_speed_label = AceGUI:Create("Label")
    exp_speed_label:SetText(data["exp_speed"])
    exp_speed_label:SetWidth(9*SCALE_LENGTH)
    title_group:AddChild(exp_speed_label)

    local money_label = AceGUI:Create("Label")
    money_label:SetText(data["money_up"])
    money_label:SetWidth(9*SCALE_LENGTH)
    title_group:AddChild(money_label)

    local money_speed = AceGUI:Create("Label")
    money_speed:SetText(data["money_speed"])
    money_speed:SetWidth(9*SCALE_LENGTH)
    title_group:AddChild(money_speed)

    return title_group
end

function XpTimer:AddHistoryData(data)

    local title_group = XpTimer:GetHisRow(data)

    XpTimer.scroll:AddChild(title_group)
end

function XpTimer:CreateHistoryWindow()

    local frame = AceGUI:Create("Frame")
    frame:SetTitle("历史数据")
    frame:SetLayout("List")
    frame:SetWidth(88*SCALE_LENGTH)
    frame:SetHeight(40*SCALE_LENGTH)

    -- add title
    local title_array = {
        ["time"] = "时间",
        ["place"] = "地点",
        ["time_long"] = "时长",
        ["level"] = "等级",
        ["exp"] = "经验",
        ["kill_num"] = "击杀数量",
        ["exp_speed"] = "经验/小时",
        ["money_up"] = "获取金币",
        ["money_speed"] = "金币/小时"
    }

    local title_row = XpTimer:GetHisRow(title_array)
    title_row:SetHeight(5*SCALE_LENGTH)
    frame:AddChild(title_row)

    local ScrollArea = AceGUI:Create("SimpleGroup")
    ScrollArea:SetLayout("Fill")
    ScrollArea:SetWidth(86*SCALE_LENGTH)
    ScrollArea:SetHeight(31*SCALE_LENGTH)
    frame:AddChild(ScrollArea)


    local scroll = AceGUI:Create("ScrollFrame")
    scroll:SetLayout("List")
    XpTimer.scroll = scroll

    ScrollArea:AddChild(scroll)

    --XpTimer:AddHistoryData(title_array)

    --XpTimer:FillTestData()

    XpTimer.HistoryWindow = frame

end

function XpTimer:HistoryShow(data_array)
    local an = table.getn(data_array)
    XpTimer.HistoryWindow:SetStatusText(string.format("总条数:%d",an))
    for i= 1, an do
        local temp_data = deepcopy(data_array[i])
        temp_data["time_long"] = string.format("%d分%d秒",
                floor(data_array[i]["time_long"]/60),floor(data_array[i]["time_long"]%60))
        local money_up = temp_data["money_up"] and temp_data["money_up"] or 0
        local money_speed = temp_data["money_speed"] and temp_data["money_speed"] or 0
        temp_data["money_up"] = string.format("%d金%d银",floor(money_up/10000),floor(money_up/100%100))
        temp_data["money_speed"] = string.format("%d金/小时",floor(money_speed*3600/10000))
        XpTimer:AddHistoryData(temp_data)
    end
end

function XpTimer:FillTestData()
    for i = 1,100 do
        local test_array = {
            ["time"] = date("%y/%m/%d %H:%M"),
            ["place"] = "血色修道院",
            ["time_long"] = 1000,
            ["level"] = string.format("%d",24),
            ["exp"] = string.format("%d",123456),
            ["kill_num"] = string.format("%d",24),
            ["exp_speed"] = string.format("%d",50000)
        }

        XpTimer:AddHistoryData(test_array)
    end
end
