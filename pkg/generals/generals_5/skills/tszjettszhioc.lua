local tszjettszhioc = fk.CreateSkill {
  name = "tszjettszhioc",
}

Fk:loadTranslationTable{
  ["tszjettszhioc"] = "折䡴",
  [":tszjettszhioc"] = "應動｡1脚色受傷旹,伱可与傷源脚色賭鬥發動,若伱:贏,伱取得對方賭鬥牌,防止此傷;輸,伱取得伱賭鬥牌;平,此技能失效1轉",

  ["#tszjettszhioc-invoke"] = "折䡴：伱可与 %dest 賭鬥 防止 %src 所受傷",

  ["$tszjettszhioc1"] = "兄弟先走,我來擋駐來人",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tszjettszhioc:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.from and data.from ~= player and player:hasSkill(tszjettszhioc.name) 
    and player:canPindian(data.from)
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player,{skill_name="tszjettszhioc",prompt="#tszjettszhioc-invoke:"..data.to.id..":"..data.from.id}) then
      event:setCostData(self,{tos={data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = data.from
    local pindian = player:pindian({to}, tszjettszhioc.name)
    if pindian.results[to].winner == player then
      if room:getCardArea(pindian.results[to].toCard) == Card.DiscardPile then
        room:moveCardTo(pindian.results[to].toCard, Card.PlayerHand, player, fk.ReasonPrey, tszjettszhioc.name, nil, true, player)
      end
      S.preventDamage({damageData=data,skillName=tszjettszhioc.name})
      room:sendLog{ type = "#PreventDamageBySkill", from = data.to.id, arg = tszjettszhioc.name }
    elseif pindian.results[to].winner == to then
      if  room:getCardArea(pindian.fromCard) == Card.DiscardPile then
        room:moveCardTo(pindian.fromCard, Card.PlayerHand, player, fk.ReasonPrey, tszjettszhioc.name, nil, true, player)
      end
    else
      room:invalidateSkill(player, tszjettszhioc.name,"-turn")  --待改
    end
  end,
})


return tszjettszhioc
