local desc_1v2 = [[
  # 鬥地主模式簡介

  ___

  水滸殺模式
  低單將彊度下 地主雙將加地主技
  地主技 勒索,剝削,逼債,放貸,奢靡,吝嗇
]]

-- Because packages are loaded before gamelogic.lua loaded
-- so we can not directly create subclass of gamelogic in the top of lua

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local toous_djis_tszuoh_getLogic = function()
  local toous_djis_tszuoh_logic = GameLogic:subclass("toous_djis_tszuoh_logic")

  function toous_djis_tszuoh_logic:initialize(room)
    GameLogic.initialize(self, room)
    self.role_table = {nil, nil, {"lord", "rebel", "rebel"}}
  end

  function toous_djis_tszuoh_logic:chooseGenerals()  --覆寫
    local room = self.room ---@type Room
    local generalNum = room:getSettings('generalNum')
    for _, p in ipairs(room.players) do
      room:setPlayerProperty(p, "role_shown", true)
      room:broadcastProperty(p, "role")
    end

    local lord = room:getLord() --[[@as ServerPlayer]]
    room:setCurrent(lord)
    local players = room.players



    local generals = room:getNGenerals(#players * generalNum)
    local req = Request:new(players, "AskForGeneral")
    req.timeout = self.room:getSettings('generalTimeout')
    for i, p in ipairs(players) do
      local arg = table.slice(generals, (i - 1) * generalNum + 1, i * generalNum + 1)
      -- if p.role == "lord" then
      --   local count = #generals
      --   table.insert(arg, generals[count])
      --   table.insert(arg, generals[count - 1])
      -- end
      req:setData(p, { arg, 1 })
      req:setDefaultReply(p, { arg[1] })
    end
    req:ask()
    local selected = {}
    for _, p in ipairs(players) do
      local general_ret
      general_ret = req:getResult(p)[1]
      room:setPlayerGeneral(p, general_ret, true, true)
      table.insertIfNeed(selected, general_ret)
    end
    generals = table.filter(generals, function(g) return not table.contains(selected, g) end)
    room:returnToGeneralPile(generals)
    for _, g in ipairs(selected) do
      room:findGeneral(g)
    end
    room:askToChooseKingdom(players)

    for _, p in ipairs(players) do
      room:broadcastProperty(p, "general")
    end


  end


  function toous_djis_tszuoh_logic:attachSkillToPlayers()  --模式技
    local room = self.room

    if room:getSettings("skill_times_limit") then
      room:addSkill("skill_times_skill")
    end

    if room:getSettings("keevs_djis_tszuoh") then
      local times=1
      local winner
      local choices = {"1","2","3","Cancel"}
      local all= {"1","2","3","Cancel"}
      local result={}
      for i, p in ipairs(room.players ) do
        local choice = room:askToChoice(p, { ---@type integer
          choices = choices,
          skill_name = "keevs_djis_tszuoh",
          prompt = "#keevs_djis_tszuoh-invoke",
          cancelable=true,
          all_choices=all,
        })

        if choice~="Cancel" then 
          times=tonumber(choice)
          winner=p 
          if choice=="3" then
            goto thenEnd 
          end
          table.insert(result,p)
          -- choices=table.filter(all, function(n) return tonumber(n)> tonumber(choice) end)
          choices={}
          for i=tonumber(choice)+1,#all,1 do
            table.insert(choices,all[i])
          end
        end
        -- result[p] =choice
      end

      -- if table.forEach(result,function(s) return s=="Cancel"  end) then room:gameOver("")
      if not winner then room:gameOver("") end

      if #result==1 then goto thenEnd end
        for i, p in ipairs(result) do
          if room:askToSkillInvoke(p, { skill_name = "tshiach_djis_tszuoh" }) then
            times=times*2
            winner=p
          end
        end
      


      ::thenEnd::
      room:setBanner("@game_odds",times)
      if winner~=room:getLord() then
        local old = room:getLord()
        old.role="rebel"
        winner.role="lord"
        room:broadcastProperty(old, "role")
        room:broadcastProperty(winner, "role")
        -- room:moveSeatTo(winner, 1, true)
        room:arrangeSeats(S.getSeats(winner))
        room:setCurrent(winner)
      end
    end

    if room:getSettings("buddyRebel") then
      local rebels={}
      for i, p in ipairs(room.players ) do
        if p.role=="rebel" then
          table.insert(rebels,p)
        end
      end
      rebels[1]:addBuddy(rebels[2])
      rebels[2]:addBuddy(rebels[1])
    end

    local addRoleModSkills = function(player, skillName)
      local skill = Fk.skills[skillName]
      if not skill then
        fk.qCritical("Skill: "..skillName.." doesn't exist!")
        return
      end
      if skill:hasTag(Skill.Lord) then
        return
      end
      if skill:hasTag(Skill.AttachedKingdom) and not table.contains(skill:getSkeleton().attached_kingdom, player.kingdom) then
        return
      end
      room:handleAddLoseSkills(player, skillName, nil, false)
    end

    for _, p in ipairs(room.alive_players) do
      for _, s in ipairs(Fk.generals[p.general]:getSkillNameList(false)) do
        addRoleModSkills(p, s)
      end
      if p.role == "lord" then
        local loredSkill = {"loeoksoak","paoksiak","piktssaes","puacsthoeojs","szjaqmxeh","ljinsssik"}  --getSetting
        local skills=room:askToChoices(p,{
        min_num=2,
        max_num=2,
        cancelable=false,
        choices=loredSkill,
        })
        room:handleAddLoseSkills(p, table.concat(skills, "|"), nil, false)  --
      end
    end
    
  end

  return toous_djis_tszuoh_logic
end

local toous_djis_tszuoh_mode = fk.CreateGameMode{
  name = "toous_djis_tszuoh_mode",
  minPlayer = 3,
  maxPlayer = 3,
  main_mode = "1v2_mode",
  logic = toous_djis_tszuoh_getLogic,
  surrender_func = function(self, playedTime)
    local surrenderJudge = { { text = "time limitation: 1 min", passed = playedTime >= 60 } }
    if Self.role ~= "lord" then
      table.insert(surrenderJudge, {
        text = "1v2: left you alive",
        passed = #table.filter(Fk:currentRoom().players, function(p)
          return p.rest > 0 or not p.dead
        end) == 2
      })
    end

    return surrenderJudge
  end,
  get_adjusted = function (self, player)
    -- if player.role == "lord" then
    --   return {hp = player.hp + 1, maxHp = player.maxHp + 1}  --旹機?
    -- end
    return {}
  end,
  reward_punish = function (self, victim, killer)
    local room = victim.room
    if victim.role == "rebel" and not room:getSettings("noRebelReward") then
      for _, p in ipairs(room:getOtherPlayers(victim)) do
        if p.role == "rebel" then
          local choices = {"draw2", "Cancel"}
          if p:isWounded() then
            table.insert(choices, 2, "recover")
          end
          local choice = room:askToChoice(p, {
            choices = choices,
            skill_name = "PickLegacy",
          })
          if choice == "draw2" then
            p:drawCards(2, "game_rule")
          elseif choice == "recover" then
            room:recover{
              who = p,
              num = 1,
              recoverBy = p,
              skillName = "game_rule",
            }
          end
        end
      end
    end
  end,
}

local W = require "ui_emu.preferences"
toous_djis_tszuoh_mode.ui_settings = {
  W.PreferenceGroup {
    title = "toous_djis_tszuoh_limit",

    W.SwitchRow {
      _settingsKey = "skill_times_limit",  --不同模式同名
      title = "skill_times_limit",
    },

    W.SwitchRow {
      _settingsKey = "buddyRebel",
      title = "toous_djis_tszuoh_buddyRebel",
    },

    W.SwitchRow {
      _settingsKey = "noRebelReward",
      title = "toous_djis_tszuoh_noRebelReward",
    },
  },

  W.PreferenceGroup {
    title = "toous_djis_tszuoh_choose_mod",

    W.SwitchRow {
      _settingsKey = "keevs_djis_tszuoh",
      title = "toous_djis_tszuoh_keevs_djis_tszuoh",
    },
  },
}

Fk:loadTranslationTable{
  ["toous_djis_tszuoh_mode"] = "鬥地主",
  [":toous_djis_tszuoh_mode"] = desc_1v2,

  ["PickLegacy"] = "挑选遗产",

  ["time limitation: 1 min"] = "游戏时长达到1分钟",
  ["1v2: left you alive"] = "仅剩你和地主存活",

  ["toous_djis_tszuoh_limit"] = "限制",
  ["skill_times_limit"] = "技能發數",
  ["help: skill_times_limit"] = "每腳色每轉每技能發動6次則失效(不要持衡技)",

  ["toous_djis_tszuoh_buddyRebel"] = "農民通牌",
  ["help: toous_djis_tszuoh_buddyRebel"] = "農民能看見隊友手牌",
  ["toous_djis_tszuoh_noRebelReward"] = "无共苦",
  ["help: toous_djis_tszuoh_noRebelReward"] = "農民无保險",

  ["toous_djis_tszuoh_choose_mod"] = "選擇模式",
  ["toous_djis_tszuoh_keevs_djis_tszuoh"] = "叫地主",
  ["help: toous_djis_tszuoh_keevs_djis_tszuoh"] = "開啓則分發手牌後叫地主",
  ["keevs_djis_tszuoh"] = "叫地主",
  ["#keevs_djis_tszuoh-invoke"] = "叫地主",
  ["tshiach_djis_tszuoh"] = "搶地主",
}

return toous_djis_tszuoh_mode
