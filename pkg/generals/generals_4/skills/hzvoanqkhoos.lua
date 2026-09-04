local hzvoanqkhoos = fk.CreateSkill{
  name = "hzvoanqkhoos",
}

Fk:loadTranslationTable{
  ["hzvoanqkhoos"] = "紈絝",
  [":hzvoanqkhoos"] = "一末段始旹,伱可發動.伱將手牌抽至體力值",

  ["$hzvoanqkhoos1"] = "鼠目寸光如何了卻我心思",
  ["$hzvoanqkhoos2"] = "吾薄有家資",
}
hzvoanqkhoos:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(hzvoanqkhoos.name) and target.phase == Player.Finish
  end,
  on_use = function(self, event, target, player, data)
    local n =  #player:getCardIds("h") 
    if n < player.hp then
    player:drawCards(player.hp-n, hzvoanqkhoos.name)
    end
  end,
})



return hzvoanqkhoos
