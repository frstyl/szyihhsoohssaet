local hzaavscxes = fk.CreateSkill {
  name = "hzaavscxes",
}

Fk:loadTranslationTable{
["hzaavscxes"] = "効義",
[":hzaavscxes"] = "伱受傷後可發動,伱抽體力上限張牌,弃置體力數x手牌",


["#hzaavscxes-draw"]="効義 抽 %arg",

["$hzaavscxes1"] = "大丈夫爲國䀆忠 死而无憾",

}

hzaavscxes:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzaavscxes.name) 
  end,
  -- on_cost= function(self, event, target, player, data)
  --    return 
  --    player.room:askToSkillInvoke(player, {
  --     skill_name = hzaavscxes.name,
  --     prompt = "#hzaavscxes-draw:::"..player:getLostHp()
  --   }) 
  -- end,
  on_use = function(self, event, target, player, data)
    player:drawCards(player.maxHp, hzaavscxes.name)
    if player.dead then return end
    local n = math.max(0,player.hp)
    room:askToDiscard(from, {
        min_num = n,
        max_num = n,
        include_equip = false,
        skill_name = hzaavscxes.name,
        cancelable = false,
        skip=false,
      })
  end,
})

return hzaavscxes
