local nziokcoavs = fk.CreateSkill{
  name = "nziokcoavs",
}


Fk:loadTranslationTable{
  ["nziokcoavs"] = "辱傲",
  [":nziokcoavs"] = "其它角色A主段始旹,伱可發動.其選1項➀對伱使用殺(无視距離有次數限制計入次數),若此殺致傷,此技能當輪失效➁視爲伱對其使用殺.",


  ["#nziokcoavs-invoke"] = "辱傲 %src主段始 是否討打",
  ["#nziokcoavs-ssaet"] = "辱傲 對 %src 使用殺",

  ["$nziokcoavs1"] = "就昰???",
}

nziokcoavs:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(nziokcoavs.name) and target.phase == Player.Play
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      skill_name=nziokcoavs.name,
      prompt="#nziokcoavs-invoke:"..target.id,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local use =room:askToUseCard(target, {
        skill_name = nziokcoavs.name,
        pattern = "ssaet",
        prompt = "#nziokcoavs-ssaet:"..player.id,
        cancelable = true,
        extra_data = {
          bypass_distances = true,
          bypass_times = false,
          exclusive_targets = {player.id},
          extraUse = false,
        }
      })
      if use then
        -- use.extraUse = true
        room:useCard(use)
		if use.damageDealt then
        room:invalidateSkill(player,nziokcoavs.name,"-round",nziokcoavs.name)
		end
      else
        room:useVirtualCard("ssaet", nil, player, target, nziokcoavs.name, false)
      end
  end,
})

return nziokcoavs
