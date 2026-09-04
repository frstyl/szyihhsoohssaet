local kiappoavh = fk.CreateSkill{
  name = "kiappoavh",
}


Fk:loadTranslationTable{
["kiappoavh"] = "劫寶",
[":kiappoavh"] = "其它脚色額外抽牌前,若其手牌全場冣多或抽牌數大于2,伱可發動.改爲伱執行,中止元旹機",

["#kiappoavh-invoke"] = "劫寶 %src 將抽%arg 是否劫取",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

kiappoavh:addEffect(fk.BeforeDrawCard, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    if  player:hasSkill(kiappoavh.name)
     and data.who~=player 
      and data.skillName~="phase_draw"
      then
     if data.num>2 then return true end
     local n =data.who:getHandcardNum()
     return table.every(player.room:getOtherPlayers(data.who), function(p) return
      p:getHandcardNum()<n
     end)
    end
  end,
  on_cost= function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = kiappoavh.name,
      prompt = "#kiappoavh-invoke:"..data.who.id.."::"..data.num,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    player.room:drawCards(player, data.num,  data.skillName.name, data.fromPlace )
    return true
  end,
})


return kiappoavh
