local hqinhmiu = fk.CreateSkill{
  name = "hqinhmiu",
}

Fk:loadTranslationTable{
  ["hqinhmiu"] = "𠃊謀",
  [":hqinhmiu"] = "其它脚色A轉始旹,伱可發動.伱𠃊祕選擇一數字.A1轉內下次聲明起動旹,若牌名字數与伱所選相同,伱可選1項➀此起動无效➁1轉脚色技能技能于1轉內失效",

  ["#hqinhmiu-invoke"] = "𠃊謀： %dest 轉始 是否發動",
  ["#hqinhmiu-choice"] = "𠃊謀： 選擇",
  ["@@hqinhmiu-turn"] = "𠃊謀 技能失效",

  ["$hqinhmiu1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$hqinhmiu2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local U = require "packages/utility/utility"

hqinhmiu:addEffect(fk.TurnStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return 
      target ~= player and player:hasSkill(hqinhmiu.name) 
  end,
  -- on_cost = function (self, event, target, player, data)
  --   local room = player.room
  --   local to = target
  --   if not room:askToSkillInvoke(player,{skill_name=hqinhmiu.name,prompt="#hqinhmiu-invoke::"..to.id,}) then
  --     return
  --     end
  --   local all_names = Fk:getAllCardNames("btd", true)
  --   local names = table.simpleClone(all_names)
  --   names=table.filter(all_names, function(name)
  --   return not table.contains(player:getTableMark("hqinhmiu"),name)
  --   end)
  --   local mark = U.askForChooseCardNames(room, player, names, 1, 1, hqinhmiu.name, "#hqinhmiu-choice:"..to.id, all_names, true, false)
  --   if #mark>0 then
  --     event:setCostData(self, {tos=to,mark=mark})
  --     return true
  --   end
  -- end,
  on_cost = function(self, event, target, player, data)
      local choices = {}
      for i=0, 99, 1 do
        table.insert(choices, tostring(i))
      end
      number = player.room:askToChoice(player, { ---@type integer
        choices = choices,
        skill_name = likbvoat.name,
        prompt = "#likbvoat-invoke::" .. data.to.id,
        cancelable=true,
      })
      if number~="Cancel" then
        event:setCostData(self,{tos={data.to},mark=tonumber(number)})
        return true
      end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local mark = event:getCostData(self).mark
    room:setPlayerMark(player, "hqinhmiu-turn",{target, mark} )
  end,
})

hqinhmiu:addEffect(fk.AfterCardUseDeclared, {--CardUsing
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return 
       player:getMark("hqinhmiu-turn")~=0
      and player:getMark("hqinhmiu-turn")[1]==data.from
  end,
  -- on_trigger = function(self, event, target, player, data)
  --   player.room:setPlayerMark(player, "hqinhmiu-turn", 0)
  -- end,
  on_cost = function (self, event, target, player, data)
      local room = player.room
      local name=player:getTableMark("hqinhmiu-turn")[1]
      player.room:setPlayerMark(player, "hqinhmiu-turn", 0)
      if name~= data.card.trueName then return end
      local choice = room:askToChoice(player, {
          choices = {"hqinhmiu-card","hqinhmiu-skil","Cancel"},
          skill_name = hqinhmiu.name,
          prompt = "#hqinhmiu-choice",
          all_choices = {"hqinhmiu-card","hqinhmiu-skil","Cancel"},
        })
      if choice=="Cancel" then return end
      event:setCostData(self, {choice = choice})
      return true

  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local choice = event:getCostData(self).choice
    if choice=="hqinhmiu-skil" then
      room:setPlayerMark(target, "@@hqinhmiu-turn", 1)
    elseif choice=="hqinhmiu-card" then
      S.useNullify(data,player,hqinhmiu.name)
    end
  end,
  -- late_refresh=true,
  -- can_refresh= function(self, event, target, player, data)
  --   return player:getMark("hqinhmiu-turn")~=0
  -- end,
  -- on_refresh = function(self, event, target, player, data)
  --   player.room:setPlayerMark(player, "hqinhmiu-prohibit-turn",nil )
  -- end,
})

hqinhmiu:addEffect("invalidity", {
  invalidity_func = function(self, from, skill)
    return from:getMark("@@hqinhmiu-turn") > 0 and skill:isPlayerSkill(from)
  end,
})



return hqinhmiu
