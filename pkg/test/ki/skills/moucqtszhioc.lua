local moucqtszhioc = fk.CreateSkill {
  name = "moucqtszhioc",
}

Fk:loadTranslationTable{
  ["moucqtszhioc"] = "冡衝",
  [":moucqtszhioc"] = "游戲始旹,伱轉始旹,若伱未裝僃<a href=':moucqtszhioc_hzaach'>戰艦</a>, 將其置入伱裝僃區.伱主段始旹",

  ["#moucqtszhioc-choose"] = "冡衝：你可以弃置一名其他脚色至多两张牌",
  ["#moucqtszhioc-invoke"] = "冡衝：裝僃戰艦",

  ["$moucqtszhioc1"] = "帥炮卽軍心",--大炮在此軍心不亂
  ["$moucqtszhioc2"] = "大其飄揚軍威雄壯",
}

local U = require "packages/utility/utility"

local spec={
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if player:hasSkill(moucqtszhioc.name) 
    and (target==player or event==fk.GameStart) then
      local catapult = table.find(U.prepareDeriveCards(player.room, {{ "moucqtszhioc_hzaach", Card.Spade, 7 }}, moucqtszhioc.name), function (id)
        return player.room:getCardArea(id) == Card.Void
      end)
      return catapult and player:canMoveCardIntoEquip(catapult)
    end
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = moucqtszhioc.name,
      prompt = "#moucqtszhioc-invoke",
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local catapult = table.find(U.prepareDeriveCards(room, {{"moucqtszhioc_hzaach", Card.Spade, 7}}, moucqtszhioc.name), function (id)
      return player.room:getCardArea(id) == Card.Void
    end)
    if catapult then
      room:setCardMark(Fk:getCardById(catapult), MarkEnum.DestructOutMyEquip, 1)
      room:moveCardIntoEquip(player, catapult, moucqtszhioc.name, true, player)
    end
  end,
}
moucqtszhioc:addEffect(fk.GameStart, spec)
moucqtszhioc:addEffect(fk.TurnStart, spec)

-- moucqtszhioc:addEffect(fk.TurnStart, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     if target == player and player:hasSkill(moucqtszhioc.name) then
--       if not table.find(player:getEquipments(Card.SubtypeTreasure), function(id)
--         return Fk:getCardById(id).name == "moucqtszhioc_hzaach"
--       end) then

--         local catapult = table.find(U.prepareDeriveCards(player.room, {{"moucqtszhioc_hzaach", Card.Diamond, 9}}, moucqtszhioc.name), function (id)
--           return player.room:getCardArea(id) == Card.Void
--         end)
--         return catapult and player:canMoveCardIntoEquip(catapult)
--       end
--     end
--   end,
--   on_cost = function(self, event, target, player, data)
--     return player.room:askToSkillInvoke(player, {
--         skill_name = moucqtszhioc.name,
--         prompt = "#moucqtszhioc-invoke",
--       }) 
--   end,
--   on_use = function(self, event, target, player, data)
--    if player.dead then return end
--    local room= player.room

--     local catapult = table.find(U.prepareDeriveCards(room, {{"moucqtszhioc_hzaach", Card.Diamond, 9}}, moucqtszhioc.name), function (id)
--       return player.room:getCardArea(id) == Card.Void
--     end)
--     if catapult then
--       room:setCardMark(Fk:getCardById(catapult), MarkEnum.DestructOutMyEquip, 1)
--       room:moveCardIntoEquip(player, catapult, moucqtszhioc.name, true, player)
--     end
--   end,
-- })

return moucqtszhioc
