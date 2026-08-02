local noosssaet = fk.CreateSkill{
  name = "noosssaet",
  max_branches_use_time = {
    ["noosssaet_hp"] = {
      [Player.HistoryPhase] = 1
    },
    ["noosssaet_hand"] = {
      [Player.HistoryPhase] = 1
    },
  }
  }

Fk:loadTranslationTable{
  ["noosssaet"] = "怒殺",
  [":noosssaet"] = "➀主旹,伱可預打出1殺,選擇1脚色除伱外體力值至大者發動.伱与其1傷.➁主旹,伱可預打出1牌非殺,選擇1脚色除伱外手牌數至大者發動.伱弃置其2牌.",

  ["#noosssaet"] = "怒殺：打出一殺，与1脚色1傷 ",
  ["#noosssaet-discard"] = "怒殺：打出一牌 對 %src 傷害+1",

  ["$noosssaet1"] = "伱昰廝是喫已熊心豹子膽。",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

noosssaet:addEffect("active", {
  anim_type = "offensive",
  prompt = "#noosssaet",
  card_num = 1,
  target_num = 1,
  -- max_phase_use_time=1,
  -- can_use = function(self, player)
    -- return player:usedSkillTimes(noosssaet.name, Player.HistoryPhase) == 0
  -- end,
  interaction = function(self, player)
    local all_choices = {"noosssaet_hp", "noosssaet_hand"}
    local choices = table.filter(all_choices, function (choice)
      return noosssaet:withinBranchTimesLimit(player, choice, Player.HistoryPhase)
    end)
    return UI.ComboBox { choices = choices, all_choices = all_choices }
  end,

  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and not player:prohibitResponse(Fk:getCardById(to_select))
    and (
      ( self.interaction.data == "noosssaet_hp" and   Fk:getCardById(to_select).trueName=="ssaet")
      or self.interaction.data == "noosssaet_hand" and   Fk:getCardById(to_select).trueName~="ssaet"
    )

  end,
  target_filter = function(self, player, to_select, selected, cards)
    if #selected > 0 or not self.interaction.data or #cards ~= 1 then return end
    local n = -999
	local t={}
    if self.interaction.data == "noosssaet_hp" then
		for _, p in ipairs(Fk:currentRoom().alive_players) do
			if p~=player then
				if p.hp>n then
					n=player.hp
					t={p}
				elseif p.hp==n then
					table.insert(t,p)
				end
			end
		end
    else
		for _, p in ipairs(Fk:currentRoom().alive_players) do
			if p~=player then
				if p:getHandcardNum()>n then
					n=player:getHandcardNum()
					t={p}
				elseif p:getHandcardNum()==n then
					table.insert(t,p)
				end
			end
		end
    end
	return table.contains(t,to_select)
  end,
  history_branch = function(self, player, data)
    return data.interaction_data
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    S.playCard(effect.from,effect.cards,noosssaet.name)
    if  target.dead then return end
	if self.interaction.data=="noosssaet_hp" then
	      room:damage{
        from = player,
        to = target,
        damage = 1,
        skillName = noosssaet.name,
      }
	else
		if target:isNude() then return end
		local cid = room:askToChooseCard(effect.from, { target = target, flag = "he", skill_name = noosssaet.name })
		room:throwCard({cid}, noosssaet.name, target, effect.from)
	end


    

    
  end,
})

return noosssaet
