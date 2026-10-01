local hqaeptssaak = fk.CreateSkill {
  name = "hqaeptssaak",
}

Fk:loadTranslationTable{
  ["hqaeptssaak"] = "厭迮",
  [":hqaeptssaak"] = "伱可廢除伱1區域",


  ["$hqaeptssaak1"] = "破阵杀敌，愿献犬马之劳！",
  ["$hqaeptssaak2"] = "虎啸既响，厭迮当附！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

hqaeptssaak:addEffect(fk.CardUsing, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hqaeptssaak.name) and target==player
  end,
  on_cost= function(self, event, target, player, data)
    local all={}
    if #player:getAvailableEquipSlots()>0 then all={"EquipSlot"} end
    if not player:isHandAreaSealed() then table.insert(all,"HandSlot") end
    if not player:isJudgeAreaSealed() then  table.insert(all,"JudgeSlot") end
    if #all==0 then return end
    local choice=player.room:askToChoice(player, { choices = all, skill_name = "hqaeptssaak",cancelable=true })
    if choice~="Cancel"  then
      event:setCostData(self,{choice=choice})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local choice=event:getCostData(self).choice
    player.room:addTableMarkIfNeed(player,"hqaeptssaak", choice)
    if choice=="EquipSlot" then choice=player:getAvailableEquipSlots() end
    player.room:abortPlayerArea(player,choice)
  end,
})

hqaeptssaak:addEffect("filter", {
  handly_cards = function (self, player)
  if not table.contains(player:getTableMark(hqaeptssaak.name), "HandSlot") then return end
       local ids = {}
    for i = 1, math.min(#Fk:currentRoom().draw_pile, 4 ), 1 do
      table.insert(ids, Fk:currentRoom().draw_pile[i])
    end
    return ids
  end,
})
return hqaeptssaak
