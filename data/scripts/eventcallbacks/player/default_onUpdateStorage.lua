local lastQuestUpdate = {}

local ec = EventCallback

ec.onUpdateStorage = function(creature, key, value, oldValue, isSpawn)
	if isSpawn then
		return
	end

	local player = Player(creature)
	if not player then
		return
	end

	local playerId = player:getId()
	local now = os.mtime()
	if not lastQuestUpdate[playerId] then
		lastQuestUpdate[playerId] = now
	end

	if lastQuestUpdate[playerId] - now <= 0 and Game.isQuestStorage(key, value, oldValue) then
		lastQuestUpdate[playerId] = os.mtime() + 100
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Your questlog has been updated.")
	end
end

ec:register()
