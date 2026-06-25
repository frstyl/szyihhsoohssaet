local ddxenqtous = fk.CreateSkill {
  name = "ddxenqtous",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["ddxenqtous"] = "纏鬥",
  [":ddxenqtous"] = "伱可使用{殺/鬥將}旹,伱可將全部手牌(至少1)轉化爲{殺/鬥將}使用發動.此牌无次數限制且不可被響應,對目幖致傷旹,{其獲得x纏鬥幖記/伱可令非目幖已損角色回復x},x爲此牌子牌數.幖記:有幖記者致傷旹,迻除1幖記,防止傷害.",
--失敗各抽1 --如過彊改陰陽轉換技

  ["#ddxenqtous"] = "纏鬥：將全部手牌轉化爲殺或鬥將",
  ["#ddxenqtous-choose"] = "纏鬥：令1角色回1",

  ["@ddxenqtous"] = "纏鬥",

  ["$ddxenqtous1"] = "賊將,怎敢暗算吾兄。",
  ["$ddxenqtous2"] = "伱止躲得我箭,須躲不得我槍。",
  ["$ddxenqtous2"] = "伱昰廝倒敢賣弄弓箭。",
  ["$ddxenqtous2"] = "賊將,不自量力",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ddxenqtous:addEffect("viewas", {
  anim_type = "offensive",
  prompt = "#ddxenqtous",
  mute_card = true,
  interaction = function(self, player)
    return UI.CardNameBox {
      choices = player:getViewAsCardNames(ddxenqtous.name, {"ssaet","tous_tsiacs"}, player:getCardIds("h")),
      all_choices = {"ssaet","tous_tsiacs"},
      default_choice = "ssaet",
    }
  end,
  card_filter = Util.FalseFunc,
  view_as = function(self, player, cards)  --待改 如轉化歬不能用 轉化後不能用
    if Fk.all_card_types[self.interaction.data] == nil then return end
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcards(player:getCardIds("h"))
    card.skillName = self.name
    -- S.iii(4)
    -- S.MixCard(card) --koaz
    return card
  end,
  before_use = function(self, player, use)
    use.disresponsiveList = table.simpleClone(player.room.players)
      local t={      
        cardid=use.card.id,
        from = player,
        tos = {},
      }
      -- player.room:setPlayerMark(player,"__ddxenqtous_tous_tsiacs-phase", t)
      use.extra_data=      use.extra_data or{}
      use.extra_data.ddxenqtous=t

  end,
  enabled_at_play = function(self, player)
    return not player:isKongcheng()  --不能用如手牌之牌
  end,
  enabled_at_response = function(self, player,response)
    return not response
  end,
})

ddxenqtous:addEffect("targetmod", {
  bypass_times = function(self, player, skill2, scope, card)
    return card and scope == Player.HistoryPhase and table.contains(card.skillNames, ddxenqtous.name)
  end,
  bypass_distances = function(self, player, skill2, card)
    return card and  table.contains(card.skillNames, ddxenqtous.name)
  end,
})


-- CardUseFinished Damage
ddxenqtous:addEffect(fk.Damage, { --DamageCaused
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    if not player.dead and player.room.logic:damageByCardEffect() then  --目幖
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
      if use_event then
        local use = use_event.data
        return use.extra_data and use.extra_data.ddxenqtous
            and use.extra_data.ddxenqtous.from==player

      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local n =#data.card.subcards
    if data.card.trueName=="tous_tsiacs" then
      local tos=table.filter(room.alive_players,function(p)
          return p~=data.to and p:isWounded()
        end)
      if #tos==0 then return end
      local to = room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = 1,
        targets = tos,
        skill_name = ddxenqtous.name,
        prompt = "#ddxenqtous-choose",
        cancelable = true,
      })
      if #to==1 then 
        room:recover({
          who = to[1],
          num = n,
          recoverBy = player,
          skillName = ddxenqtous.name,
        })
      end
    else
      room:addPlayerMark(data.to,"@ddxenqtous",n)
    end
  end,
})

ddxenqtous:addEffect(fk.DamageCaused, { --砸自己
  is_delay_effect = true,
  can_refresh= function(self, event, target, player, data)
    return data.from and data.from:getMark("@ddxenqtous")>0
  end,
  on_refresh= function(self, event, target, player, data)
    player.room:removePlayerMark(data.from,"@ddxenqtous",1)
    S.preventDamage({damageData=data,skillName=ddxenqtous.name})
  end,
})

-- ddxenqtous:addEffect(fk.Damaged, { --砸自己
--   is_delay_effect = true,
--   can_trigger = function(self, event, target, player, data)
--     if target~=player 
--     or player.dead 
--     or (not data.card )

--     or data.card.name~="tous_tsiacs"
--     or (not table.contains(data.card.skillNames, ddxenqtous.name))  then return end

--       local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
--       if use_event then
--         local use = use_event.data
--         return use.extra_data and use.extra_data.ddxenqtous
--             and use.extra_data.ddxenqtous.from==player

--       end

--   end,
--   on_trigger = function(self, event, target, player, data)
--     player:drawCards(1,ddxenqtous.name)
--     data.from:drawCards(1,ddxenqtous.name)
--   end,
-- })

return ddxenqtous
