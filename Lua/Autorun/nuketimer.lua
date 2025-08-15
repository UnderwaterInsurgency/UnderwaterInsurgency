  Hook.Add("signalReceived.broadcastcomponent", "BroadcastComponentCode", function(signal, connection)

	local item = connection.item

	if SERVER then

		local chat_message = ChatMessage.Create(nil, signal, ChatMessageType.Default, nil, nil)
		local popup_message = ChatMessage.Create(nil, signal, ChatMessageType.MessageBoxInGame, nil, nil)
	
		for key, client in pairs(Client.ClientList) do
			-- the first message is responsible for text chat 
			Game.SendDirectChatMessage(chat_message, client)
			-- second message is responsible for the pop-ups that appear in chat
			Game.SendDirectChatMessage(popup_message, client)
		end
	end
  end)