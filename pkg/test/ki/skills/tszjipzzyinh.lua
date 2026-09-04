local tszjipzzyinh = fk.CreateSkill{
  name = "tszjipzzyinh",
}

Fk:loadTranslationTable{
  ["tszjipzzyinh"] = "執盾",--zzyinh
  [":tszjipzzyinh"] = "一脚色起動牌旹,伱記錄其牌色,轉終淸除記錄｡其它腳色｢殺｣對目幖生效前,伱可發動,伱占卜,若占卜牌色含于記錄,起動對此目幖无效",

  ["#tszjipzzyinh-invoke"] = "執盾 %src 對 %dest 起動 %arg 是否發動",

  ["@tszjipzzyinh-turn"] = "執盾",

  ["$tszjipzzyinh1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$tszjipzzyinh2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszjipzzyinh:addEffect(fk.CardUsing, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(tszjipzzyinh.name,true)
    and not table.contains(player:getTableMark("@tszjipzzyinh-turn"), data.card.color)
  end,
  on_trigger = function (self, event, target, player, data)
    player.room:addTableMark(player,"@tszjipzzyinh-turn", data.card:getColorString(true))
  end,
})

tszjipzzyinh:addEffect(fk.PreCardEffect, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(tszjipzzyinh.name)
    and data.card.trueName=="ssaet"
    and data.from~=player
  end,
  on_cost = function (self, event, target, player, data)
      if 
      player.room:askToSkillInvoke(player, {
        skill_name = tszjipzzyinh.name,
        prompt = "#tszjipzzyinh-invoke:"..data.from.id..":"..data.to.id..":"..data.card:toLogString(),
        }) 
      then
        event:setCostData(self,{tos={data.to}})
        return true
      end
    end,
  on_use = function (self, event, target, player, data)
    local pattern = {}
    for _, color in ipairs(player:getTableMark("@tszjipzzyinh-turn"))  do
      table.insertIfNeed(pattern,color:split("_")[2])
    end
    local judge = {
      who = player,
      reason = tszjipzzyinh.name,
      pattern = ".|.|"..table.concat(pattern,","),
    }
    player.room:judge(judge)
    if judge:matchPattern() then
      S.effectNullify(data,player,tszjipzzyinh.name,true)
    end

  end,
})



return tszjipzzyinh
