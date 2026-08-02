local kaasssik_active = fk.CreateSkill {
  name = "kaasssik_active",
}

Fk:loadTranslationTable{
  ["kaasssik_active"] = "稼穡",
  [":kaasssik_active"] = ".",

  ["#kaasssik-one"] = "將葢伏牌轉化爲 糧艸先行 對 一脚色 起動",
  ["#kaasssik-all"] = "對一脚色褈復執行",

  ["$kaasssik_active1"] = "好一匹棗紅馬",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

kaasssik_active:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#kaasssik_active",
  -- interaction = function(self)
  --   return UI.ComboBox {
  --     choices = {"kaasssik-one", "kaasssik-all",},
  --   }
  -- end,
  min_card_num=1,
  -- card_num=function(slef,player)
  --   return self.interaction.data== "kaasssik-one" and 1 or 0
  -- end,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(kaasssik_active.name, Player.HistoryPhase) == 0
  -- end,
  max_target_num = 1,
  card_filter = function (self, player, to_select, selected)
    return table.contains(self.expand_pile, to_select)
  end,
  target_filter = function(self, player, to_select, selected,selected_cards)
    if #selected ~= 0 then return end
    return true 
      -- local c=Fk:cloneCard("liac_tshoavh_seen_hzaac") 
      -- if #selected_cards==1  then
      --   c:addSubcards(selected_cards)
      --   return player:canUseTo(c,to_select)
      -- -- else
      -- --   for _, id in ipairs(S.getPlayerKoarbiukCards(player)) do
      -- --     c:addSubcard(id)
      -- --     if player:canUseTo(c,selected) then
      -- --       return true
      -- --     end
      -- --   end
      -- -- end
      -- end 
  end,
  -- feasible = function(self, player, selected, selected_cards)
  --   if #selected=0 then 

  --   end 
  --   return true
  -- end,
  on_use = function(self, room, effect)
    local player=effect.from
    local to =effect.tos[1]
  end,
})


return kaasssik_active
