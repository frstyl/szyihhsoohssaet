local sk = fk.CreateSkill {
  name = "puj_hqeens_nooh_skill&",  --&幖記非武將技主動
  attached_equip = "puj_hqeens_nooh",
}
Fk:loadTranslationTable{
  ["puj_hqeens_nooh_skill&"] = "飛燕弩",
  [":puj_hqeens_nooh_skill&"] = "出牌阶段限4次,无視次數使用1殺",
  ["#puj_hqeens_nooh&"] = "發動飛燕弩 无視次數使用殺(發動後未使用殺也消耗飛燕弩次數)",
  ["#puj_hqeens_nooh_ssaet"] = "飛燕弩 使用殺",
}

sk:addEffect("active", {
  prompt = "#puj_hqeens_nooh&",
  max_phase_use_time = 4,
  card_filter = Util.FalseFunc,
  on_use = function(self, room, effect)
    -- effect.from:drawCards(1, self.name)
    local params = { ---@type AskToUseCardParams
      skill_name = "ssaet",
      pattern = "ssaet",
      prompt = "#puj_hqeens_nooh_ssaet",
      cancelable = true,
      extra_data = {
        -- must_targets = {data.to.id},  --必選
        -- exclusive_targets = {data.to.id},  --必選其一
        -- bypass_distances = true,
        bypass_times = true,
      }
    }
    local use = room:askToUseCard(effect.from, params)
      if use then 
      use.extraUse = true 
      room:useCard(use)
      end

  end,
})


return sk
