local khuoqjyek = fk.CreateSkill {
  name = "khuoqjyek",
}

Fk:loadTranslationTable{
  ["khuoqjyek"] = "區役",
  [":khuoqjyek"] = "一末段始旹,伱可投出1手牌,選擇1至多腳色(其1轉內層爲伱起動目幖)發動,伱對所選腳色虛擬起動｢脅迫｣",

  ["#khuoqjyek-invoke"] = "區役 脅迫",

}

local S = require "packages/szyihhsoohssaet/szyih_guos"

khuoqjyek:addEffect(fk.EventPhaseStart, {
  can_trigger = function(self, event, target, player, data)
    return   data.phase==Player.Finish and player:hasSkill(khuoqjyek.name)  
    and  not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local targets = {}
      room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
        local use=e.data
          if use.from==player and use.tos then
            table.insertTableIfNeed(targets,use.tos)
          end

      end, Player.HistoryTurn)
      if #targets==0 then return end
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_num = 1,
        max_num = 99,
        min_card_num = 1,
        max_card_num = 1,
        targets = targets,
          pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
          return not player:prohibitResponse(Fk:getCardById(id))
        end)}),
        skill_name = khuoqjyek.name,
        prompt = "#khuoqjyek-invoke",
        cancelable = true,
      })

      if #tos > 0 and #cards>0 then
        event:setCostData(self,{cards=cards,tos=tos})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local ids=event:getCostData(self).ids
    S.playCard(event:getCostData(self).cards,khuoqjyek.name,player)
    if player.dead then return end

    local room=player.room
        player.room:useCard({
          from = player,
          tos = event:getCostData(self).tos,
          card = Fk:cloneCard("hsiap_paak"),
        })

  end,
})


-- khuoqjyek:addEffect("maxcards", {
--   exclude_from = function(self, player, card)
--     return card:getMark("@@khuoqjyek-inhand-turn") > 0
--   end,
-- })

-- khuoqjyek:addEffect("targetmod", {
--   residue_func = function(self, player, skill, scope)
--     if player:getMark("ssaet_times-turn") > 0 and skill.trueName == "ssaet_skill" and scope == Player.HistoryPhase then
--       return player:getMark("ssaet_times-turn")
--     end
--   end,
-- })
return khuoqjyek
