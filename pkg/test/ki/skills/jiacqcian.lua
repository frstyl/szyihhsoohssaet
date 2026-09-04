local jiacqcian = fk.CreateSkill{
  name = "jiacqcian",
}

Fk:loadTranslationTable{
  ["jiacqcian"] = "宣言",
  [":jiacqcian"] = "其它脚色轉始旹,伱可發動.伱𠃊祕選擇一非裝僃牌名.1轉脚色1轉首次聲明起動非裝僃牌旹,若牌名与伱所選相同,伱可選1項➀此起動无效➁1轉脚色技能技能于1轉內失效",

  ["#jiacqcian-invoke"] = "宣言： %dest 轉始 是否發動",
  ["#jiacqcian-choice"] = "宣言： 選擇",
  ["@@jiacqcian-turn"] = "宣言 技能失效",

  ["$jiacqcian1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$jiacqcian2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local U = require "packages/utility/utility"

jiacqcian:addEffect(fk.TurnStart, {
  anim_type = "control",
  derived_piles = "$jiacqcian",
  can_trigger = function(self, event, target, player, data)
    return 
      target ~= player and player:hasSkill(jiacqcian.name) 
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local to = target
    if not room:askToSkillInvoke(player,{skill_name=jiacqcian.name,prompt="#jiacqcian-invoke::"..to.id,}) then
      return
      end
    local all_names = Fk:getAllCardNames("btd", true)
    local names = table.simpleClone(all_names)
    names=table.filter(all_names, function(name)
    return not table.contains(player:getTableMark("jiacqcian"),name)
    end)
    local mark = U.askForChooseCardNames(room, player, names, 1, 1, jiacqcian.name, "#jiacqcian-choice:"..to.id, all_names, true, false)
    if #mark>0 then
      event:setCostData(self, {to=to,mark=mark})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local mark = event:getCostData(self).mark
    room:setPlayerMark(player, "zzikkoot-turn", mark)
  end,
})

jiacqcian:addEffect(fk.AfterCardUseDeclared, {--CardUsing
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return  target.room.current == target 
      and (data.card.type ~= Card.TypeEquip) 
      and #player:getTableMark("zzikkoot-turn")~=0
  end,
  -- on_trigger = function(self, event, target, player, data)
  --   player.room:setPlayerMark(player, "zzikkoot-turn", 0)
  -- end,
  on_cost = function (self, event, target, player, data)
      local room = player.room
      local name=player:getTableMark("zzikkoot-turn")[1]
      player.room:setPlayerMark(player, "zzikkoot-turn", 0)
      if name~= data.card.trueName then return end
      local choice = room:askToChoice(player, {
          choices = {"jiacqcian-card","jiacqcian-skil","Cancel"},
          skill_name = jiacqcian.name,
          prompt = "#jiacqcian-choice",
          all_choices = {"jiacqcian-card","jiacqcian-skil","Cancel"},
        })
      if choice=="Cancel" then return end
      event:setCostData(self, {choice = choice})
      return true

  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local choice = event:getCostData(self).choice
    if choice=="jiacqcian-skil" then
      player:drawCards(2,jiacqcian.name)
      room:setPlayerMark(target, "@@jiacqcian-turn", 1)
    elseif choice=="jiacqcian-card" then
      data.nullified=true
    end
  end,
})

jiacqcian:addEffect("invalidity", {
  invalidity_func = function(self, from, skill)
    return from:getMark("@@jiacqcian-turn") > 0 and skill:isPlayerSkill(from)
  end,
})



return jiacqcian
