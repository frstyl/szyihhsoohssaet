local tszjipkrak = fk.CreateSkill{
  name = "tszjipkrak",
}

Fk:loadTranslationTable{
  ["tszjipkrak"] = "執戟",--zzyinh
  [":tszjipkrak"] = "其它腳色起動｢殺｣對目幖生效旹,伱可發動,目幖改爲伱,效果改爲｢鬥將｣",

  ["#tszjipkrak-invoke"] = "執戟 %src 對 %dest 起動 %arg 是否發動",


  ["$tszjipkrak1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$tszjipkrak2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 



tszjipkrak:addEffect(fk.CardEffecting, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(tszjipkrak.name)
    and data.card.trueName=="ssaet"
    and data.from and data.from~=player
  end,
  on_cost = function (self, event, target, player, data)
      if 
      player.room:askToSkillInvoke(player, {
        skill_name = tszjipkrak.name,
        prompt = "#tszjipkrak-invoke:"..data.from.id..":"..data.to.id..":"..data.card:toLogString(),
        }) 
      then
        event:setCostData(self,{tos={data.to}})
        return true
      end
    end,
  on_use = function (self, event, target, player, data)
    if data.to~=player then data.extra_data = data.extra_data or {} data.extra_data.origin_to=data.extra_data.origin_to or data.to   data.to=player end
    data:changeCardSkill("tous_tsiacs_skill")
  end,
})



return tszjipkrak
