local uiFunctions = {} -- Create a table/object

-- Looks for the first item with tag "ui_cupcakeTeleportPoint" and returns it
function uiFunctions.getCupcakeTeleportPoint() -- Define functions as method of uiFunctions
	for _, item in pairs(Item.ItemList) do
		if (item.HasTag("ui_cupcakeTeleportPoint")) then
			return item
		end
	end
end

-- Log stuff in console
function uiFunctions.consoleLog(message, sender)
	if (sender == error) then
		sender = "[UI ERROR]"
	elseif (sender == debug) then
		sender = "[UI DEBUG]"
	elseif (sender == nil) then
		sender = "[UI]"
	end
	
	print(sender .. ": " .. message)
end

return uiFunctions -- Return our object will all methods