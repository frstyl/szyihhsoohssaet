Fk:loadTranslationTable{
  ["prachkouc"] = "秉公",
  [":prachkouc"] = "預段始旹,伱選擇1x>0角色發動,其將x手牌交与除其外一角色,若x>2,伱可令其回1(x=該角色手牌數-其體力值)",

  ["#prachkouc-choose"] = "秉公 選擇發動目幖",
  ["#prachkouc-give-choose"] = "秉公 選擇 %arg 牌交与1其它角色",
  ["#prachkouc-recover"] = "秉公 令 %srec 回1",

  ["$prachkouc1"] = "可知寨中規矩",

}

local prachkouc = fk.CreateSkill{
  name = "prachkouc",
}

prachkouc:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(prachkouc.name) and player.phase == Player.Start
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local to = room:askToChoosePlayers(player, {
      targets = table.filter(room.alive_players, function(p)
        return #p:getCardIds("h")>p.hp
      end),
      min_num = 1,
      max_num = 1,
      prompt = "#prachkouc-choose",
      skill_name = prachkouc.name,
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local to = event:getCostData(self).tos[1]
    local n=#to:getCardIds("h")-to.hp
    local tos, cards = room:askToChooseCardsAndPlayers(to, {
      min_card_num = n,
      max_card_num = n,
      min_num = 1,
      max_num = 1,
      targets = room:getOtherPlayers(to),
      skill_name = prachkouc.name,
      prompt = "#prachkouc-give-choose:::"..n,
      cancelable = false,
      will_throw = false,
    })
    room:moveCardTo(cards, Player.Hand, tos[1], fk.ReasonGive, prachkouc.name, nil, false, to.id)
    if n>2 and not player.dead and player:isWounded() 
    and room:askToSkillInvoke(player, {
      skill_name = prachkouc.name,
      prompt = "#prachkouc-recover:"..to.id,
    }) then
      room:recover{
        who = to,
        num = 1,
        recoverBy = player,
        skillName = prachkouc.name,
      }
    end
  end,
})

return prachkouc
