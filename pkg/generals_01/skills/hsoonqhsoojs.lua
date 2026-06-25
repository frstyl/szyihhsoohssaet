local hsoonqhsoojs = fk.CreateSkill{
  name = "hsoonqhsoojs",
  -- tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["hsoonqhsoojs"] = "昏晦",
  -- [":hsoonqhsoojs"] = "其它角色轉始旹記錄伱手牌數,當轉終,若伱手牌与記錄不同,伱可發動,爲當轉角色附加盲目",
  [":hsoonqhsoojs"] = "其它它角色轉終,若伱手牌數于當轉變化,伱可發動,爲當轉角色附加盲目", --𪑒䵪

  ["hsoonqhsoojs_mjens"] = "无濟",

  ["$hsoonqhsoojs1"] = "我欲行夏禹旧事，为天下人。",

}

hsoonqhsoojs:addEffect(fk.TurnStart, {
  anim_type = "drawcard",
  can_refresh= function (self, event, target, player, data)
    return  target~=player and player:hasSkill(hsoonqhsoojs.name,true)  
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(player,"hsoonqhsoojs-turn",#player:getCardIds("h"))
  end,
})
hsoonqhsoojs:addEffect(fk.TurnEnd, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return  target~=player and player:hasSkill(hsoonqhsoojs.name) and  player:getMark("hsoonqhsoojs-turn") ~= #player:getCardIds("h")
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    S.addTsziukzzyitBuff(target,  "maacqmiuk",player)
  end,
})



return hsoonqhsoojs
