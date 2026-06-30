local ddxevhhsioc = fk.CreateSkill{
  name = "ddxevhhsioc",
}
Fk:loadTranslationTable{
  ["ddxevhhsioc"] = "兆凶",
  [":ddxevhhsioc"] = "末段始旹,選擇1其它有負咒術角色發動.其流失1體力",

  ["#ddxevhhsioc-choose"] = "兆凶 令1角色流失1體力",

  ["$ddxevhhsioc1"] = "太歲䡴刻必有血灮之災",
  ["$ddxevhhsioc2"] = "昰劫數貧道料汝是躲不闓已",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

ddxevhhsioc:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ddxevhhsioc.name) and player.phase == Player.Finish
  end,
  on_cost = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = table.filter(player.room.alive_players,function(p)
        return S.hasTsziukzzyit(p,"debuff")
      end),
      skill_name = ddxevhhsioc.name,
      prompt = "#ddxevhhsioc-choose",
      cancelable = true,
    })
    if #tos>0 then
      event:setCostData(self,{tos=tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:loseHp(event:getCostData(self).tos[1],1,ddxevhhsioc.name)  --无源
  end,
})


return ddxevhhsioc
