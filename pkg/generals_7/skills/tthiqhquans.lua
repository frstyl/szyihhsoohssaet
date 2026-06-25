local tthiqhquans = fk.CreateSkill {
  name = "tthiqhquans",
}

Fk:loadTranslationTable{
["tthiqhquans"] = "癡怨",
[":tthiqhquans"] = "其它角色回復體力後,伱可發動.其判定,若爲♠♥,伱抽2,♣♦,伱可弃1手牌,令其弃2手牌",

["#tthiqhquans-invoke"] = "癡怨 是否弃1手牌令%src弃2手牌",
["#tthiqhquans-discard"] = "癡怨弃2手牌",
["$tthiqhquans"] = "海棠花開陣陣香",

}

--DamageInflicted
tthiqhquans:addEffect(fk.HpRecover, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return  target~=player and player:hasSkill(tthiqhquans.name) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local judge = {
      who = target,
      reason = tthiqhquans.name,
      pattern = ".|.|spade,club,heart,dimond",
    }
    room:judge(judge)
    local suit=judge.card and judge.card.suit
    if suit==Card.Heart or suit==Card.Dimond then  
      player:drawCards(2,tthiqhquans.name)
      return
    end
    if suit==Card.Club or suit==Card.Spade then  
      local discard = room:askToDiscard(player, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = tthiqhquans.name,
        cancelable = true,
        prompt = "#tthiqhquans-invoke:"..target.id,
      })
      if #discard > 0 then
      room:askToDiscard(target, {
        min_num = 2,
        max_num = 2,
        include_equip = false,
        skill_name = tthiqhquans.name,
        cancelable = false,
        prompt = "#tthiqhquans-discard",
      })
      end
      return
    end
    
  end,
})

return tthiqhquans
