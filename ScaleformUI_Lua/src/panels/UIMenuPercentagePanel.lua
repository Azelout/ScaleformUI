UIMenuPercentagePanel = setmetatable({}, UIMenuPercentagePanel)
UIMenuPercentagePanel.__index = UIMenuPercentagePanel
UIMenuPercentagePanel.__call = function() return "UIMenuPanel", "UIMenuPercentagePanel" end

---New
---@param title string
---@param colorType int
---@param startIndex number
function UIMenuPercentagePanel.New(title, minText, maxText, initialValue)
	_UIMenuPercentagePanel = {
		Min = minText or "0%",
		Max = maxText or "100%",
		Title = title or "Opacity",
		Percentage = initialValue or 0.0,
		ParentItem = nil, -- required
		OnPercentagePanelChange = function(item, panel, value) end
	}
	return setmetatable(_UIMenuPercentagePanel, UIMenuPercentagePanel)
end

function UIMenuPercentagePanel:Percentage(value)
	if value ~= nil then
		self.Percentage = value
		if self.ParentItem ~= nil and self.ParentItem:SetParentMenu() ~= nil and self.ParentItem:SetParentMenu():Visible() then
			local it = IndexOf(self.ParentItem:SetParentMenu().Items, self.ParentItem)
			local van = IndexOf(self.ParentItem.Panels, self)
			ScaleformUI.Scaleforms._ui:CallFunction("SET_PERCENT_PANEL_RETURN_VALUE", false, it, van, value)
		end
	else
		return self.Percentage
	end
end

---SetParentItem
---@param Item table
function UIMenuPercentagePanel:SetParentItem(Item) -- required
	if not Item() == nil then
		self.ParentItem = Item
	else
		return self.ParentItem
	end
end