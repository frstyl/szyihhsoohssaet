local jiuqlioc = fk.CreateSkill {
  name = "jiuqlioc",
  tags={Skill.Switch},
}

Fk:loadTranslationTable{
  ["jiuqlioc"] = "游龍",
  [":jiuqlioc"] = "伱起動牌旹,若其色爲{➀紅/➁黑},伱可發動,伱抽1｡不可連續發動相同項",

  ["#jiuqlioc-choose"] = "游龍 選擇初始態",
  ["jiuqlioc-yang"] = "昜 紅色牌",
  ["jiuqlioc-yin"] = "侌 黑色牌",

  ["$jiuqlioc1"] = "吾军杀声震天，则敌心必乱！",
  ["$jiuqlioc2"] = "阵前亢歌，以振军心！",
}

local U = require "packages/utility/utility"

jiuqlioc:addEffect(fk.GameStart, {
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(jiuqlioc.name, true)
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

jiuqlioc:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jiuqlioc.name) and data.card.color==player:getSwitchSkillState(jiuqlioc.name, true)+1
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, jiuqlioc.name)
  end,
})


return jiuqlioc
