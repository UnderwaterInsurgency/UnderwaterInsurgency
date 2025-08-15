Hook.Add("character.created", "setTeam", function(character)
    
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