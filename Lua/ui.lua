if CLIENT then return end -- All of these should only be run on the server

-- Round start command
Hook.Add("chatMessage", "ui_startRound", function(message, client)
	if (message == "!startround" and client.checkPermission(0x80)) then -- Only allow clients with console command permissions to start rounds
		local startDoorsFound = 0
		for _, item in pairs(Item.ItemList) do
			if (item.HasTag("ui_startDoor") and item.GetComponentString("Door")) then -- Check for items with "ui_startDoor" tags and a "Door" component
				startDoorsFound = startDoorsFound+1 -- Count and later print found doors for debugging purposes
				local doorComponent = item.GetComponentString("Door")
				doorComponent.IsOpen = true
				local property = doorComponent.SerializableProperties[Identifier("IsOpen")]
				Networking.CreateEntityEvent(item, Item.ChangePropertyEventData(property, doorComponent))
			end
		end
		if (startDoorsFound) then print("[UI Debug]: " .. startDoorsFound .. " doors with tag 'ui_startDoor' found") end

		for _, character in pairs(Character.CharacterList) do
			if (character.Group == "cupcake") then -- All cupcakes have group="cupcake" so if we find any we should try and teleport them
				if (not cupcakeTeleportPoint) then cupcakeTeleportPoint = getCupcakeTeleportPoint() end -- If we don't have an item to teleport them to yet, call the helper function to find one with the tag "ui_cupcakeTeleportPoint"
				if (not cupcakeTeleportPoint) then print("[UI Error]: No item with tag 'ui_cupcakeTeleportPoint' found") break end -- If we couldn't find an item with the tag, log an error and abort
				character.TeleportTo(cupcakeTeleportPoint.WorldPosition)
			end
		end
		Game.SendMessage("THE ROUND HAS STARTED!", 11)
		return true -- Don't print command to chat
	end
end)

function getCupcakeTeleportPoint() -- Helper function that looks for the first item with tag "ui_cupcakeTeleportPoint" and returns it
	for _, item in pairs(Item.ItemList) do
		if (item.HasTag("ui_cupcakeTeleportPoint")) then
			return item
		end
	end
end

-- Change team of warband classes
Hook.Add("character.created", "setTeam", function(character) -- 
    
	local jobId = character.JobIdentifier.Value
	local species = character.SpeciesName.Value
	
    if jobId == "warboss" or jobId == "piraterifleman" or jobId == "piratemelee" or jobId == "pirategrenadier" or jobId == "pirateshieldbearer" then
		Timer.Wait(function()
		character.SetOriginalTeamAndChangeTeam(2)
		character.UpdateTeam()
		local cardItem = character.Inventory.GetItemInLimbSlot(InvSlotType.Card)
		if cardItem then
			local idCard = cardItem.GetComponentString("IdCard")
			idCard.TeamID = 2
		end
	end, 1500)
    end
	
end)