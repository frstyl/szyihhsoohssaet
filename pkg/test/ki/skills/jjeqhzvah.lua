local jjeqhzvah = fk.CreateSkill{
  name = "jjeqhzvah",
}

Fk:loadTranslationTable{
  ["jjeqhzvah"] = "迻禍",
  [":jjeqhzvah"] = "伱成爲起動目幖旹,若爲進攻牌｡伱可打出1紅色牌發動｡伱將目幖轉迻至伱下家",
--加彊?

  ["#jjeqhzvah-invoke"] = "迻禍 打出1紅牌 將 %arg 轉移 至 %dest ",


  ["$jjeqhzvah1"] = "太歲頭上也敢動土",

}
local S = require "packages/szyihhsoohssaet/szyih_guos"


jjeqhzvah:addEffect(fk.TargetConfirming, {
  can_trigger = function(self, event, target, player, data)
    return target == player 
    and player:hasSkill(jjeqhzvah.name) 
    and not data.cancelled 
    and S.isAttackCard(data.card.trueName)
    and   not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to =S.getNextOne(player)
		local cards = S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = false,
		  skill_name = jjeqhzvah.name,
		  cancelable = true,
      pattern = ".|.|red",
      prompt = "#jjeqhzvah-invoke::"..to.id..":::"..data.card:toLogString() ,
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards,tos={to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    S.playCard(event:getCostData(self).cards, jjeqhzvah.name,player)
    if data:cancelCurrentTarget() then
      data:addTarget(to)
    end
  end,
})

return jjeqhzvah
