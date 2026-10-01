local hsoonqhsoojs = fk.CreateSkill{
  name = "hsoonqhsoojs",
  -- tags = { Skill.Compulsory },
  related_skills={"tsziukzzyit_maacqmiuk"},
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["hsoonqhsoojs"] = "昏晦",
  -- [":hsoonqhsoojs"] = "其它脚色轉始旹記錄伱手牌數,1轉終,若伱手牌与記錄不同,伱可發動,爲1轉脚色附加盲目",
  [":hsoonqhsoojs"] = "一脚色轉終,若伱手牌數相對于轉始變化,伱可選擇1其它腳色發動,爲其附加咒術｢盲目｣", --𪑒䵪

  ["#hsoonqhsoojs-choose"] = "昏晦 選擇其它腳色發動",

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
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayers(player),  --
      skill_name = hsoonqhsoojs.name,
      prompt = "#hsoonqhsoojs-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    S.addTsziukzzyitBuff(event:getCostData(self).tos[1],  "maacqmiuk",player)
  end,
})



return hsoonqhsoojs
