local piucqcxim = fk.CreateSkill{
  name = "piucqcxim",
}


Fk:loadTranslationTable{
["piucqcxim"] = "風吟",
[":piucqcxim"] = "末段始旹,伱可發動.伱占卜.伱可打出1牌与占卜牌同點者",
-- [":piucqcxim"] = "末段始旹,伱可發動.伱占卜,若与此流程內上次占卜牌類別不同,伱可再次占卜.流程終止旹,伱選擇令1脚色抽x或回x/2",

["#piucqcxim-choose"] = "日新 選擇牌打出 ",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

piucqcxim:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(piucqcxim.name) and target == player and player.phase == Player.Finish
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local tos = room:askToChoosePlayers(player, {
  --         targets = targets,
  --         min_num = 0,
  --         max_num = 999,
  --         prompt = "#piucqcxim-choose",
  --         skill_name = piucqcxim.name,
  --         cancelable = true,
  --       })
  --   if #tos > 0 then
  --     event:setCostData(self, {tos = tos})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    local room = player.room

    while true do
      local judge = {
        who = player,
        reason = piucqcxim.name,
        pattern = ".|.|.",
      }
      room:judge(judge)
      
      local yes, dat = room:askToUseActiveSkill(player, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
      skill_name = "piucqcxim_active",
      prompt = "#pujqkiams-choose",
      cancelable = true,
      skip = true,  --不執行
      extra_data = {
        num = judge.card.number,
      },
      --  = {ids=ids},
      })
      if yes and dat then
        S.responseCards(player,dat.cards)
      else
        return 
      end
    end
  end,
})

return piucqcxim
