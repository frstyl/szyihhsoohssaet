local loohdvoat = fk.CreateSkill {
  name = "loohdvoat",
}

Fk:loadTranslationTable{
  ["loohdvoat"] = "擄奪",
  [":loohdvoat"] = "伱對其它腳色致傷後,若其裝僃區有牌,伱可發動取得其裝僃區內1牌",

  ["#loohdvoat-invoke"] = "擄奪 %dest",

  ["$loohdvoat1"] = "後發先至",

}

-- local U = require "packages/utility/utility"
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 


loohdvoat:addEffect(fk.Damaged, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.from==player  and player:hasSkill(loohdvoat.name) 
    and #data.to:getCardIds("e")>0
  end,
  can_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, { skill_name = loohdvoat.name,prompt="#loohdvoat-invoke::"..data.to.id }) then
      event:setCostData(self,{tos={data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
      if player.dead or data.to.dead or #data.to:getCardIds("e")==0 then return end
    local cid = room:askToChooseCard(player, { target =data.to, flag = "e", skill_name = loohdvoat.name })
    room:obtainCard(player, cid, false, fk.ReasonPrey, player, loohdvoat.name)
  end,
})

return loohdvoat
