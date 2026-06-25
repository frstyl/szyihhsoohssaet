local tszjettszhioc = fk.CreateSkill {
  name = "tszjettszhioc",
}

Fk:loadTranslationTable{
  ["tszjettszhioc"] = "折䡴",
  [":tszjettszhioc"] = "當1角色受到傷害,若伱可与傷源角色拼點,伱可發動發動.伱与之拼點,若伱贏,伱獲得對方拼點牌,防止此傷.若伱沒贏,伱獲得伱拼點牌,此技能本轉失效.",

  ["#tszjettszhioc-choose"] = "折䡴：伱可与 %dest 拼點 防止 %src 所受傷",

  ["$tszjettszhioc1"] = "兄弟先走,我來擋駐來人",
}

tszjettszhioc:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.from and data.from ~= player and player:hasSkill(tszjettszhioc.name) 
    and player:canPindian(data.from)
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{skill_name="tszjettszhioc",prompt="#tszjettszhioc-choose:"..data.to.id..":"..data.from.id})
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = data.from
    local pindian = player:pindian({to}, tszjettszhioc.name)
    if pindian.results[to].winner == player then
      if room:getCardArea(pindian.results[to].toCard) == Card.DiscardPile then
        room:moveCardTo(pindian.results[to].toCard, Card.PlayerHand, player, fk.ReasonJustMove, tszjettszhioc.name, nil, true, player)
      end
      data:preventDamage()  ---不自動發報
      room:sendLog{ type = "#PreventDamageBySkill", from = data.to.id, arg = tszjettszhioc.name }
    else
      if  room:getCardArea(pindian.fromCard) == Card.DiscardPile then
        room:moveCardTo(pindian.fromCard, Card.PlayerHand, player, fk.ReasonJustMove, tszjettszhioc.name, nil, true, player)
      end
      room:invalidateSkill(player, tszjettszhioc.name,"-turn")  --待改
    end
  end,
})


return tszjettszhioc
