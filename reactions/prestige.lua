local reaction = {}
function reaction.run(message, interaction, data, response)
  local ujf = "savedata/" .. message.author.id .. ".json"
  local uj = dpf.loadjson(ujf, defaultjson)
  print("Loaded uj")

  if response == "yes" then
    print('user1 has accepted')

    for k, v in pairs(uj.storage) do
      if k ~= "rdcards" then
        uj.storage[k] = uj.storage[k] - 1
        if uj.storage[k] == 0 then uj.storage[k] = nil end
      end
    end

    uj.storage["rdcards"] = uj.storage["rdcards"] and uj.storage["rdcards"] + 1 or 1

    cmd.checkmedals.run(message, nil, message.channel)

    interaction:reply("You feel your storage getting a lot lighter. The **RDCards** card gets added to your storage.")

	  dpf.savejson(ujf,uj)
  end

  if response == "no" then
    print('user1 has denied')
    interaction:reply("You decide not to prestige.")
  end
end
return reaction
