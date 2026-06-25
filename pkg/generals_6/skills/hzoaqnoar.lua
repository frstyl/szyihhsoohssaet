Fk:loadTranslationTable{
  ["hzoaqnoar"] = "何奈",
  [":hzoaqnoar"] = "其它角色主段始旹,伱可將1紅桃手牌轉化爲无中生有對其使用",

  ["#hzoaqnoar-use"] = "何奈 昰否將紅桃手牌轉化爲无中生有對 %src 使用",

  ["$hzoaqnoar1"] = "實事難入公門虛事難已抵對",
  ["$hzoaqnoar2"] = "旣肰昰桃花已開也顧不了若多",
}

local hzoaqnoar = fk.CreateSkill{
  name = "hzoaqnoar",
}

hzoaqnoar:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target.phase == Player.Play and player:hasSkill(hzoaqnoar.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local use = player.room:askToUseVirtualCard(player, {
      name = "muo_ttiuc_ssaac_qiuh",
      skill_name = hzoaqnoar.name,
      prompt = "#hzoaqnoar-use:"..target.id,
      cancelable = true,
      extra_data = {
        must_targets = {target.id},
        exclusive_targets = {target.id},
        bypass_distances = false,
        bypass_times = true,
      },
      card_filter = {
        n = 1,
        pattern=".|.|heart|hand",  --
        -- cards = cards,
      },
      skip = true,
    })
    if use then
      event:setCostData(self, { extra_data = use })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).extra_data)
  end,
})


return hzoaqnoar
