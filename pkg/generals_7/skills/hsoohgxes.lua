
local hsoohgxes = fk.CreateSkill{
  name = "hsoohgxes",
  tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
["hsoohgxes"] = "虎騎",
[":hsoohgxes"] = "鎖定.➀伱至其他角色距離-1.➁主段始旹觸發,伱可視爲使用1殺",

["#hsoohgxes-choose"] = "虎騎 選擇一角色 視爲對其使用殺",
}

hsoohgxes:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(hsoohgxes.name) then
      return -1
    end
  end,
})

hsoohgxes:addEffect(fk.EventPhaseStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hsoohgxes.name) and player.phase == Player.Play
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(room:getOtherPlayers(player, false), function (p)
      return player:canUseTo(Fk:cloneCard("ssaet"), p, {bypass_distances = false, bypass_times = true})
    end)
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,
      prompt = "#hsoohgxes-choose",
      skill_name = hsoohgxes.name,
      cancelable = true,  --可不用
    })
    if #to~=0 then  
      player.room:useVirtualCard("ssaet", nil, player, to, hsoohgxes.name, true)
    end
  end,
})
return hsoohgxes
