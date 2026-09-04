local jiuqlioc = fk.CreateSkill {
  name = "jiuqlioc",
  tags={Skill.Switch},
}

Fk:loadTranslationTable{
  ["jiuqlioc"] = "游龍",
  [":jiuqlioc"] = "伱起動或演練牌旹,若其色爲{➀紅/➁黑},伱可發動,伱抽1｡不可連續發動相同項",

  ["#jiuqlioc-choose"] = "游龍 選擇初始態",
  ["jiuqlioc-yang"] = "➀昜 紅色牌",
  ["jiuqlioc-yin"] = "➁侌 黑色牌",

  ["$jiuqlioc1"] = "吾军杀声震天，则敌心必乱！",
  ["$jiuqlioc2"] = "阵前亢歌，以振军心！",
}

local U = require "packages/utility/utility"


jiuqlioc:addAcquireEffect(function (self, player,is_start)  --失去不褈置 𡴘可自選
  if is_start then return end 
    local room = player.room
    local choice = room:askToChoice(player, {
      choices = { "jiuqlioc-yang", "jiuqlioc-yin" },
      skill_name = jiuqlioc.name,
      prompt = "#jiuqlioc-choose",
    })
    choice = choice:endsWith("yang") and fk.SwitchYang or fk.SwitchYin
    U.SetSwitchSkillState(player, jiuqlioc.name, choice)
end)

jiuqlioc:addEffect(fk.GameStart, { --fk.EventAcquireSkill
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return 
    -- data.who==player
    -- and data.skill.name==jiuqlioc.name
    -- and
     player:hasSkill(jiuqlioc.name, true)
  end,
  -- on_cost = Util.TrueFunc,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local choice = room:askToChoice(player, {
      choices = { "jiuqlioc-yang", "jiuqlioc-yin" },
      skill_name = jiuqlioc.name,
      prompt = "#jiuqlioc-choose",
    })
    choice = choice:endsWith("yang") and fk.SwitchYang or fk.SwitchYin
    U.SetSwitchSkillState(player, jiuqlioc.name, choice)
  end,
})

local spec={
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jiuqlioc.name) and data.card.color==player:getSwitchSkillState(jiuqlioc.name, true)+1
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, jiuqlioc.name)
  end,
}

jiuqlioc:addEffect(fk.CardUsing, spec)
jiuqlioc:addEffect(fk.CardResponding, spec)


return jiuqlioc
