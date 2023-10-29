function Player:onLook(thing, position, distance)
	local description = ""
	local onLook = EventCallback.onLook
	if onLook then
		description = onLook(self, thing, position, distance, description)
	end

	if description ~= "" then
		self:sendTextMessage(MESSAGE_INFO_DESCR, description)
	end
end

function Player:onLookInBattleList(creature, distance)
	local description = ""
	local onLookInBattleList = EventCallback.onLookInBattleList
	if onLookInBattleList then
		description = onLookInBattleList(self, creature, distance, description)
	end

	if description ~= "" then
		self:sendTextMessage(MESSAGE_INFO_DESCR, description)
	end
end

function Player:onLookInTrade(partner, item, distance)
	local description = "You see " .. item:getDescription(distance)
	local onLookInTrade = EventCallback.onLookInTrade
	if onLookInTrade then
		description = onLookInTrade(self, partner, item, distance, description)
	end

	if description ~= "" then
		self:sendTextMessage(MESSAGE_INFO_DESCR, description)
	end
end

function Player:onLookInShop(itemType, count)
	local description = "You see "
	local onLookInShop = EventCallback.onLookInShop
	if onLookInShop then
		description = onLookInShop(self, itemType, count, description)
	end

	if description ~= "" then
		self:sendTextMessage(MESSAGE_INFO_DESCR, description)
	end
end

function Player:onMoveItem(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	local onMoveItem = EventCallback.onMoveItem
	if onMoveItem then
		return onMoveItem(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	end
	return RETURNVALUE_NOERROR
end

function Player:onItemMoved(item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	local onItemMoved = EventCallback.onItemMoved
	if onItemMoved then
		onItemMoved(self, item, count, fromPosition, toPosition, fromCylinder, toCylinder)
	end
end

function Player:onMoveCreature(creature, fromPosition, toPosition)
	local onMoveCreature = EventCallback.onMoveCreature
	if onMoveCreature then
		return onMoveCreature(self, creature, fromPosition, toPosition)
	end
	return true
end

function Player:onViolationWindow(targetName, reason, action, comment, statement, statementId, ipBanishment)
	local onViolationWindow = EventCallback.onViolationWindow
	if onViolationWindow then
		onViolationWindow(self, targetName, reason, action, comment, statement, statementId, ipBanishment)
	end
end

function Player:onReportRuleViolation(targetName, reportType, reportReason, comment, translation)
	local onReportRuleViolation = EventCallback.onReportRuleViolation
	if onReportRuleViolation then
		onReportRuleViolation(self, targetName, reportType, reportReason, comment, translation)
	end
end

function Player:onReportBug(message)
	local onReportBug = EventCallback.onReportBug
	if onReportBug then
		return onReportBug(self, message)
	end
	return true
end

function Player:onRotateItem(item)
	local onRotateItem = EventCallback.onRotateItem
	if onRotateItem then
		return onRotateItem(self, item)
	end
	return true
end

function Player:onTurn(direction)
	local onTurn = EventCallback.onTurn
	if onTurn then
		return onTurn(self, direction)
	end
	return true
end

function Player:onTradeRequest(target, item)
	local onTradeRequest = EventCallback.onTradeRequest
	if onTradeRequest then
		return onTradeRequest(self, target, item)
	end
	return true
end

function Player:onTradeAccept(target, item, targetItem)
	local onTradeAccept = EventCallback.onTradeAccept
	if onTradeAccept then
		return onTradeAccept(self, target, item, targetItem)
	end
	return true
end

function Player:onTradeCompleted(target, item, targetItem, isSuccess)
	local onTradeCompleted = EventCallback.onTradeCompleted
	if onTradeCompleted then
		onTradeCompleted(self, target, item, targetItem, isSuccess)
	end
end

function Player:onGainExperience(source, exp, rawExp, sendText)
	local onGainExperience = EventCallback.onGainExperience
	return onGainExperience and onGainExperience(self, source, exp, rawExp, sendText) or exp
end

function Player:onLoseExperience(exp)
	local onLoseExperience = EventCallback.onLoseExperience
	return onLoseExperience and onLoseExperience(self, exp) or exp
end

function Player:onGainSkillTries(skill, tries)
	local onGainSkillTries = EventCallback.onGainSkillTries
	if not APPLY_SKILL_MULTIPLIER then
		return onGainSkillTries and onGainSkillTries(self, skill, tries) or tries
	end

	if skill == SKILL_MAGLEVEL then
		tries = tries * configManager.getNumber(configKeys.RATE_MAGIC)
		return onGainSkillTries and onGainSkillTries(self, skill, tries) or tries
	end
	tries = tries * configManager.getNumber(configKeys.RATE_SKILL)
	return onGainSkillTries and onGainSkillTries(self, skill, tries) or tries
end

function Player:onInventoryUpdate(item, slot, equip)
	local onInventoryUpdate = EventCallback.onInventoryUpdate
	if onInventoryUpdate then
		onInventoryUpdate(self, item, slot, equip)
	end
end

function Player:onNetworkMessage(recvByte, msg)
	local handler = PacketHandlers[recvByte]
	if not handler then
		--io.write(string.format("Player: %s sent an unknown packet header: 0x%02X with %d bytes!\n", self:getName(), recvByte, msg:len()))
		return
	end

	handler(self, msg)
end
