function canJoin(player)
	return player:getAccountType() >= ACCOUNT_TYPE_GAMEMASTER
end

function onSpeak(player, type, message)
	local playerAccountType = player:getAccountType()
	if type == TALKTYPE_CHANNEL_Y then
		if playerAccountType == ACCOUNT_TYPE_GOD then
			type = TALKTYPE_CHANNEL_W
		end
	elseif type == TALKTYPE_CHANNEL_W then
		if playerAccountType ~= ACCOUNT_TYPE_GOD then
			type = TALKTYPE_CHANNEL_Y
		end
	elseif type == TALKTYPE_CHANNEL_RN then
		if playerAccountType ~= ACCOUNT_TYPE_GOD and not player:hasFlag(PlayerFlag_CanTalkRedChannel) then
			type = TALKTYPE_CHANNEL_Y
		end
	end
	return type
end
