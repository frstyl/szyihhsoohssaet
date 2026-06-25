local skill_name = "play_card_skill"

local skill = fk.CreateSkill{
  name = skill_name,
}

skill:addEffect('active', {
  card_filter = function(self, player, to_select, selected)
    if #selected >= self.num then
      return false
    end

    return table.contains(self.canPlay, to_select)
  end,
  min_card_num = function(self, player) return self.min_num end,
  max_card_num = function(self, player) return self.num end,
})



return skill
