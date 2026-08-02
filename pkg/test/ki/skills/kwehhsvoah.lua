local kwehhsvoah = fk.CreateSkill({
  name = "kwehhsvoah",
})

Fk:loadTranslationTable{
  ["kwehhsvoah"] = "詭火",
  [":kwehhsvoah"] = "伱起動牌前,伱可選1脚色A發動｡ A可弃1牌,若其未弃牌或所弃牌与伱所起動牌同花,伱予其1火傷",

  ["#kwehhsvoah-ask"] = "詭火：  選擇目幖 ",
  ["#kwehhsvoah-discard"] = "詭火：%src 是否弃牌 ",

  ["$kwehhsvoah1"] = "你信吗？",
  ["$kwehhsvoah2"] = "猜猜看呐~",
}
kwehhsvoah:addEffect(fk.PreCardUse, {
  can_trigger = function (self, event, target, player, data)
    return  target==player and player:hasSkill(kwehhsvoah.name)
    and not data.card:isVirtual()
  end,
  on_cost= function (self, event, target, player, data)
    local targets = player.room:getOtherPlayers(player)

    local  tos =player.room:askToChoosePlayers(player, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#kwehhsvoah-ask",
      skill_name = kwehhsvoah.name,
      cancelable=true,
    })
    if #tos > 0 then
      event:setCostData(self, { tos = tos })
      return true
    end
  end,
  on_use= function (self, event, target, player, data)
    local  to =event:getCostData(self).tos[1]
    local room=player.room
    local result = room:askToDiscard(to, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = kwehhsvoah.name,
        cancelable = true,
        prompt = "#kwehhsvoah-discard:"..player.id,
      })
    if #result==0 or Fk:getCardById(result[1]):compareSuitWith(data.card) then
      room:damage{
        from = player,
        to = to,
        damage = 1,
        damageType=fk.FireDamage,
        skillName = kwehhsvoah.name,
      }
    end
  end,
  })
-- kwehhsvoah:addEffect("viewas", {
--   pattern = ".",
--   -- interaction = function(self, player)
--   --   local all_names = Fk:getAllCardNames("bt")
--   --   local names = player:getViewAsCardNames(kwehhsvoah.name, all_names)
--   --   if #names == 0 then return end
--   --   return UI.CardNameBox { choices = names, all_choices = all_names }
--   -- end,
--   filter_pattern = {
--     min_num = 1,
--     max_num = 1,
--     pattern = ".|.|.|^equip",
--   },
--   view_as = function(self, player, cards)
--     if #cards ~= 1 then return end
--     local card = Fk:cloneCard(Fk:getCardById(cards[1]).name)
--     card:addFakeSubcards(cards)
--     card.skillName = kwehhsvoah.name
--     return card
--   end,
--   before_use = function(self, player, use)
--     local room = player.room
--     local cards = use.card.fake_subcards

--     room:moveCardTo(cards, Card.Processing, nil, fk.ReasonPut, kwehhsvoah.name, nil, false, player)

--     local  to =player.room:askToChoosePlayers(player, {
--       targets = room:getOtherPlayers(player),
--       min_num = 1,
--       max_num = 1,
--       prompt = "#kwehhsvoah-ask",
--       skill_name = kwehhsvoah.name,
--       cancelable=false
--     })[1]

--     local result = room:askToDiscard(to, {
--         min_num = 1,
--         max_num = 1,
--         include_equip = true,
--         skill_name = kwehhsvoah.name,
--         cancelable = true,
--         prompt = "#kwehhsvoah-discard:"..player.id,
--       })
--     if #result==0 or Fk:getCardById(result[1]):compareSuitWith(Fk:getCardById(cards[1])) then
--       room:damage{
--         from = player,
--         to = to,
--         damage = 1,
--         damageType=fk.FireDamage,
--         skillName = kwehhsvoah.name,
--       }
--     end
--   end,
--   enabled_at_play = function(self, player)
--     return not player:isKongcheng()
--   end,
--   enabled_at_response = function(self, player, response)
--     return not player:isKongcheng()
--   end,
-- })

return kwehhsvoah
