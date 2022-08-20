local command = {}
function command.run(message, mt)
  print(message.author.name .. " did !inventory")
  local uj = dpf.loadjson("savedata/" .. message.author.id .. ".json",defaultjson)

  local enableShortNames = false
  local enableSeason = false
  local filterSeason = false
  
  local filterSeason0 = false
  local filterSeason1 = false
  local filterSeason2 = false
  local filterSeason3 = false
  local filterSeason4 = false
  local filterSeason5 = false
  local filterSeason6 = false
  local filterSeason7 = false
  local filterSeason8 = false
  local filterSeason9 = false

  local pagenumber = 1

  args = {}
  for substring in mt[1]:gmatch("%S+") do
    table.insert(args, substring)
  end

  for index, value in ipairs(args) do
    if tonumber(value) then
      pagenumber = math.floor(tonumber(value))
    end
    if value == "-s" then
      enableShortNames = true
	  print("-s enabled")
    elseif value == "-season" then
      enableSeason = true
	  print("-season enabled")
	elseif value == "-season0" then
	  filterSeason = true
	  filterSeason0 =true
	  print("-season0 enabled")
    elseif value == "-season1" then
	  filterSeason = true
	  filterSeason1 = true
	  print("-season1 enabled")
	elseif value == "-season2" then
	  filterSeason = true
	  filterSeason2 = true
	  print("-season2 enabled")
	elseif value == "-season3" then
	  filterSeason = true
	  filterSeason3 = true
	  print("-season3 enabled")
	elseif value == "-season4" then
	  filterSeason = true
	  filterSeason4 = true
	  print("-season4 enabled")
	elseif value == "-season5" then
	  filterSeason = true
	  filterSeason5 = true
	  print("-season5 enabled")
	elseif value == "-season6" then
	  filterSeason = true
	  filterSeason6 = true
	  print("-season6 enabled")
	elseif value == "-season7" then
	  filterSeason = true
	  filterSeason7 = true
	  print("-season7 enabled")
	elseif value == "-season8" then
	  filterSeason = true
	  filterSeason8 = true
	  print("-season8 enabled")
	elseif value == "-season9" then
	  filterSeason = true
	  filterSeason9 = true
	  print("-season9 enabled")
	end
  end

  local invtable = {}
  local invstring = ''
  local invfilter = {}
  
  if filterSeason0 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 0 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason1 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 1 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason2 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 2 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason3 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 3 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason4 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 4 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason5 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 5 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason6 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 6 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason7 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 7 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason8 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 8 then
	    invfilter[k] = v
	  end
	end
  end
  if filterSeason9 == true then
    for k,v in pairs(uj.inventory) do
	  if cdb[k].season == 9 then
	    invfilter[k] = v
	  end
	end
  end

  pagenumber = math.max(1, pagenumber)
  
  local numcards = 0
  if filterSeason == true then
    for k in pairs(invfilter) do numcards = numcards + 1 end
  else
    for k in pairs(uj.inventory) do numcards = numcards + 1 end
  end
  local maxpn = math.ceil(numcards / 10)
  pagenumber = math.min(pagenumber, maxpn)
  print("Page number is " .. pagenumber)
  
  if filterSeason ~= true then
    if enableShortNames == true then
		for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
	elseif enableSeason == true then
		for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (Season " .. cdb[k].season.. ")\n") end
	else
		for k,v in pairs(uj.inventory) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
	end
  else
	if enableShortNames == true then
		for k,v in pairs(invfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (" .. k.. ")\n") end
	elseif enableSeason == true then
		for k,v in pairs(invfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. " (Season " .. cdb[k].season.. ")\n") end
	else
		for k,v in pairs(invfilter) do table.insert(invtable, "**" .. (cdb[k].name or k) .. "** x" .. v .. "\n") end
	end
  end
  table.sort(invtable)
  
  for i = (pagenumber - 1) * 10 + 1, (pagenumber) * 10 do
    print(i)
    if invtable[i] then invstring = invstring .. invtable[i] end
  end

  message.channel:send{
    content = message.author.mentionString .. ", your inventory contains:",
    embed = {
      color = 0x85c5ff,
      title = message.author.name .. "'s Inventory",
      description = invstring,
      footer = {
        text =  "(Page " .. pagenumber .. " of " .. maxpn .. ")",
        icon_url = message.author.avatarURL
      }
    }
  }
end
return command
