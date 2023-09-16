function Creature:onChangeOutfit(outfit)
	local onChangeOutfit = EventCallback.onChangeOutfit
	if onChangeOutfit then
		return onChangeOutfit(self, outfit)
	end
	return true
end

function Creature:onAreaCombat(tile, isAggressive)
	local onAreaCombat = EventCallback.onAreaCombat
	if onAreaCombat then
		return onAreaCombat(self, tile, isAggressive)
	end
	return RETURNVALUE_NOERROR
end

function Creature:onTargetCombat(target)
	local onTargetCombat = EventCallback.onTargetCombat
	if onTargetCombat then
		return onTargetCombat(self, target)
	end
	return RETURNVALUE_NOERROR
end

function Creature:onHear(speaker, words, type)
	local onHear = EventCallback.onHeard
	if onHear then
		onHear(self, speaker, words, type)
	end
end

function Creature:onUpdateStorage(key, value, oldValue, isSpawn)
	local onUpdateStorage = EventCallback.onUpdateStorage
	if onUpdateStorage then
		onUpdateStorage(self, key, value, oldValue, isSpawn)
	end
end
