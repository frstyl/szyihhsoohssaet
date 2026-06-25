
local cardSkill = fk.CreateSkill{
  name = "liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac_skill",
}

Fk:loadTranslationTable{
  ["#doar_nnaavs_kaoc_tsziu"] = "大鬧江州 是否解救%src", 
  -- ["#bvoat_toav_siac_dzsios"] = "拔刀相助 弃此牌与1其它角色伏區1延旹牌",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {--因流程而使用 因牌效而使用
  prompt="#doar_nnaavs_kaoc_tsziu",
-- prompt = function(self, _, _, _, extra_data)
  --   return (extra_data and extra_data.doar_nnaavs_kaoc_tsziu) and "#doar_nnaavs_kaoc_tsziu"  
  -- or "#bvoat_toav_siac_dzsios"  --拔刀主旹
  -- end,
  target_num = 1,
  can_use = Util.FalseFunc,  --不能主動旹用
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player 
    and to_select:getMark("@loav")>0
  end,
  target_filter = Util.CardTargetFilter,


  on_effect = function(self, room, effect)
    room:setPlayerMark(effect.to,"@loav",0)
  end,
})

cardSkill:addEffect(fk.TurnEnd, {
  -- priority = 0,  --1
  -- global = true,
  can_trigger = function(self, event, target, player, data)
    local to= S.getNextOne(target.id,1)
    if target==player and to and to:getMark("@loav")>0  then

       local players = S.getHolders("liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac")
       if #players> 0  then
        event:setCostData(self,{players=players})
        return  true
      end

    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=target.room
    local to = S.getNextOne(target.id,1)
    local params={  --旣視感--askToUseRealCard active  非askForUse 无旹機 can_use有效
      pattern = "liac_ssaen_hsoavh_hsoans_kiap_puap_ddiac",
      skill_name = "doar_nnaavs_kaoc_tsziu",  --提示
      prompt = "#doar_nnaavs_kaoc_tsziu:"..to.id,
      cancelable = true,
      skip = true,
      -- event_data = data,
      extra_data = {
        fix_targets={to.id},
        doar_nnaavs_kaoc_tsziu = true,
      }
    }
    
    local use = room:askToNullification(event:getCostData(self).players, params)  --選上家再選下家?
    if use then 
      -- use.tos={to.id}

      room:useCard(use)
    end
  end,
})


return cardSkill
