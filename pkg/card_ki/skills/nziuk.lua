local cardSkill = fk.CreateSkill {
  name = "nziuk_skill",
}

Fk:loadTranslationTable{
  ["#AskForNziuk"] = "%src 生命危急，需要 %arg 个【肉】",
  ["#AskForNziukSelf"] = "伱生命危急，需要 %arg 个【肉】",
}

cardSkill:addEffect("cardskill", {
  prompt = "#nziuk_skill",
  mod_target_filter = function(self, player, to_select)
    return to_select:isWounded()
  end,
  can_use = Util.CanUseToSelf,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to:isWounded() and not effect.to.dead then
      room:recover{
        who = effect.to,
        num = 1,
        card = effect.card,
        recoverBy = effect.from,
        skillName = cardSkill.name,
      }
    end
  end,
})

cardSkill:addAI(nil, "__card_skill")
cardSkill:addAI(nil, "default_card_skill")


local S = require "packages/szyihhsoohssaet/szyih_guos" 
--getAllCardNames
--Fk:currentRoom().disabled_packs,
cardSkill:addEffect(fk.AskForPeaches, {  --按 當 體力變化後若小于0瀕死  --今爲 瀕死者不再觸發瀕死
  -- global = true,
  -- mute = true,
  priority = 0.001,  --攔game_rule求桃  --變成先問技能 按 本是先問技能 每个桃問一輪
  can_trigger = function(self, event, target, player, data)
    return player.seat==1
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    if room:getTag("SkipGameRule") then
      room:setTag("SkipGameRule", false)
      return false
    end

    local dyingPlayer = data.who

    while not ( dyingPlayer.dead) and dyingPlayer.hp < 1 do  --回復不觸發瀕死

      -- local players=table.filter(room:getOtherPlayers(dyingPlayer), function(p)
      --   return not (p:prohibitUse("nziuk") or p:isProhibited(dyingPlayer, "nziuk"))
      -- end
      -- )
      -- local players=room:getOtherPlayers(dyingPlayer)  --牌多于1, 不判斷

      -- local cardNames = {"nziuk","jiak"}
      local s_params = {}
      
      local params = { ---@type AskToUseCardParams
        skill_name = "nziuk",
        pattern = "nziuk,jiak",
        prompt = "#AskForNziuk:" .. dyingPlayer.id .. "::" .. tostring(1 - dyingPlayer.hp),
        cancelable = true,
        extra_data = {
          -- tsiuhRecover = true,  --能用到?
          must_targets = { dyingPlayer.id },
          fix_targets = { dyingPlayer.id }
        }
      }

      -- s_params[dyingPlayer.id] = table.simpleClone(params)
      s_params[dyingPlayer.id] = s_params[dyingPlayer.id] or {}
      s_params[dyingPlayer.id].pattern= "nziuk,tsiuh"
      s_params[dyingPlayer.id].prompt = "#AskForNziukSelf:::" .. tostring(1 - dyingPlayer.hp)
      s_params[dyingPlayer.id].extra_data = {
          tsiuhRecover = true,
          must_targets = { dyingPlayer.id },
          fix_targets = { dyingPlayer.id }
        }

      local nziuk_use = S.askToUseKoarbiukCard(room,room.alive_players, params,s_params)
      if  not nziuk_use then  
        return true
      end
      if  nziuk_use.card.trueName == "analeptic" then
        nziuk_use.extra_data=nziuk_use.extra_data or {}
        nziuk_use.extra_data.tsiuhRecover=true
      end

      room:useCard(nziuk_use)
    end

    return true  --中止旹機
  end,
})


return cardSkill
