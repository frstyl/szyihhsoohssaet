
local ex__ljetkrak = fk.CreateSkill{
  name = "ex__ljetkrak",
}
Fk:loadTranslationTable{
["ex__ljetkrak"] = "烈戟",
[":ex__ljetkrak"] = "轉限x.伱段始旹,預弃1牌發動,伱越過當段,起動虛擬殺,此殺无視次數距離,目標上限+1,結算期閒伱无視防具",

["#ex__ljetkrak-invoke"] = "烈戟 %arg 選擇所弃牌 与殺目幖 自動迻除不合理目幖",
["#ex__ljetkrak-use"] = "烈戟 伱可起動1牌",
}


ex__ljetkrak:addEffect(fk.EventPhaseChanging, {
  anim_type = "offensive",
  times = function(self, player)
    return  math.max(1,player:getLostHp()) - player:usedSkillTimes(ex__ljetkrak.name, Player.Turn)
  end,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ex__ljetkrak.name) 
    and not data.skipped
    and data.phase>1 and data.phase<8
    and self.times(self,player)>0
  end,
  on_cost = function(self, event, target, player, data)
    if player:isNude() then return end
    local room=player.room
    --   local targets = table.filter(room:getOtherPlayers(player, false), function (p)
    --   return player:canUseTo(Fk:cloneCard("ssaet"), p, {bypass_distances = true, bypass_times = true})
    -- end)
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_num = 1,
        max_num = 2,
        min_card_num = 1,
        max_card_num = 1,
        targets = room:getOtherPlayers(player, false),
        pattern = ".|.|.",
        skill_name = ex__ljetkrak.name,
        prompt = "#ex__ljetkrak-invoke:::"..Util.PhaseStrMapper(data.phase),
        cancelable = true,
        will_throw = true,
      })
    if #tos>0 and #cards>0 then
        event:setCostData(self, {targets = tos, cards = cards})  --not tos
        return true
    end
    end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    data.skipped = true
    local targets = event:getCostData(self).targets
    -- room:sortByAction(targets)

    room:throwCard(event:getCostData(self).cards, ex__ljetkrak.name, player, player)
    player.room:addPlayerMark(player, "@@ignore_Armor",1)
    room:useVirtualCard("ssaet", nil, player, targets, ex__ljetkrak.name, true)  --zzin souk
    player.room:removePlayerMark(player, "@@ignore_Armor",1)

  end,
})



return ex__ljetkrak
