function print(...)
    toPrint = ""
    for i,v in ipairs(arg) do
        toPrint = toPrint..tostring(v).." "
    end

    DEFAULT_CHAT_FRAME:AddMessage(toPrint)
end

function ChatSpammerStart(text, channel, interval, amount)
    if ChatSpammerTimer then
        ChatSpammerStop()
    end

    print("Spamming started")

    channel = channel or "World"
    interval = interval or 60
    amount = amount or -1

    channel = string.upper(channel)

    local messagefunc

    if  channel == "YELL" or
        channel == "SAY" or
        channel == "PARTY" or
        channel == "RAID" or
        channel == "GUILD" or
        channel == "OFFICER"
    then
        messagefunc =  function() SendChatMessage(text, channel, nil, nil) end
    else
        local id = FindChannelIDByNameOrID(channel)
        if id == 0 then
            print("channel", channel, "not found")
            return
        end

        messagefunc = function() SendChatMessage(text, "CHANNEL", nil, id)  end
    end

    messagefunc()

    ChatSpammerTimer = C_Timer.NewTicker(interval, messagefunc, amount-1)
end

function FindChannelIDByNameOrID(name)
    if not name then
        return 0
    end

    local id = GetChannelName(name)
    if id ~= 0 then
        return id
    end

    local id1, name1,
    id2, name2, id3, name3, id4, name4,id5, name5,id6, name6,id7, name7,id8, name8,id9, name9, id10, name10 = GetChannelList()

    if string.upper(name1) == string.upper(name) then
        return id1
    elseif string.upper(name2) == string.upper(name) then
        return id2
    elseif string.upper(name3) == string.upper(name) then
        return id3
    elseif string.upper(name4) == string.upper(name) then
        return id4
    elseif string.upper(name5) == string.upper(name) then
        return id5
    elseif string.upper(name6) == string.upper(name) then
        return id6
    elseif string.upper(name7) == string.upper(name) then
        return id7
    elseif string.upper(name8) == string.upper(name) then
        return id8
    elseif string.upper(name9) == string.upper(name) then
        return id9
    elseif string.upper(name10) == string.upper(name) then
        return id10
    end

    return 0
end

function ChatSpammerStop()
    print ("Spamming stopped")
    stopSpamming()
end

function stopSpamming()
    ChatSpammerTimer:Cancel()
end
