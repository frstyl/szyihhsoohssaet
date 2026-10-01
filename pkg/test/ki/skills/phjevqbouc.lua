local phjevqbouc = fk.CreateSkill {
  name = "phjevqbouc",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["phjevqbouc"] = "飄蓬",
  [":phjevqbouc"] = "一轉終必發,伱褈鑄半(下整)手牌",  --成爲過目幖?

  ["#phjevqbouc-recast"] = "飄蓬 褈鑄 %arg",



  ["$phjevqbouc1"] = "給我活剝了",
  ["$phjevqbouc2"] = "客觀,昰可是上好黃牛肉",
}

phjevqbouc:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(phjevqbouc.name) 
    and #player:getCardIds("h")>1
  end,
  on_use = function(self, event, target, player, data)
    local n=#player:getCardIds("h")//2
    if n<1 then return end
    local room=player.room
    local cards = room:askToCards(player, {
      min_num = n,
      max_num = n,
      skill_name = phjevqbouc.name,
      -- pattern = ".",
      include_equip=false,
      prompt = "#phjevqbouc-recast:::"..n,
    })
    room:recastCard(cards, player, phjevqbouc.name)
  end,
})


return phjevqbouc
