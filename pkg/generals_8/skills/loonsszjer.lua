local loonsszjer = fk.CreateSkill {
  name = "loonsszjer",
}

Fk:loadTranslationTable{
  ["loonsszjer"] = "論策",
  [":loonsszjer"] = "主旹,預弃任意牌發動.伱抽所弃牌數,然後伱可展示3手牌選擇1角色.其選1項➀使用其中1牌,伱与其各抽1{+1}➁使用全部可用牌,无視距離次數{且不可響應}➂執行1{+1}主旹.伱于其選擇旹同旹選擇,若所選相同,增改效果",

  ["#loonsszjer"] = "論策：預弃任意牌發動",
  ["#loonsszjer-choose"] = "論策：展示三牌選一角色",
  ["#loonsszjer-choice"] = "論策：選擇",
  ["loonsszjer-useOne"] = "用一",
  ["loonsszjer-useAll"] = "用全",
  ["loonsszjer-play"] = "執行主旹",


  ["$loonsszjer1"] = "容我思量片刻",
  ["$loonsszjer2"] = "敵已露怯 㤂擊勿失",
  ["$loonsszjer3"] = "敵勢未明 當徐進緩圖",
  ["$loonsszjer3"] = "諸將共勉 戮力克敵",
  ["$loonsszjer5"] = "忠言不聽 敗績不遠",
}

loonsszjer:addEffect("active", {
  anim_type = "support",
  prompt = "#loonsszjer",
  min_card_num = 0,
  target_num = 0,
  -- max_phase_use_time = 1,
  -- max_round_use_time = 1,
  -- can_use = function(self, player)
  --   return true
  -- end,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(loonsszjer.name, Player.HistoryPhase) == 0
  -- end,
  card_filter =  function(self, player, to_select, selected)
    return not player:prohibitDiscard(to_select)
  end,
  -- target_filter = function(self, player, to_select, selected)
  --   return #selected == 0
  -- end,
  on_use = function(self, room, effect)
    local player=effect.from
    room:throwCard(effect.cards, loonsszjer.name, player, player)
    if player:isAlive() then
      player:drawCards(#effect.cards, loonsszjer.name)  --𢧵胡??
    end
    if player:getHandcardNum()<3 then return end

    local to ,cards =  room:askToChooseCardsAndPlayers(player, {
      min_card_num = 3,
      max_card_num = 3,
      min_num = 1,
      max_num = 1,
      targets = room.alive_players,
      skill_name = loonsszjer.name,
      prompt = "#loonsszjer-choose",
      cancelable = true,
    })
    if #to<1 then return end

    to =to[1]
    player:showCards(cards)
    -- local to = effect.tos[1]
    -- to:drawCards(3, loonsszjer.name, "top", "loonsszjer-inhand")
    -- if to.dead then return end
    local choices={"loonsszjer-useOne","loonsszjer-useAll","loonsszjer-play"}
    local choice= room:askToChoice(to, {
          choices = choices,
          skill_name = loonsszjer.name,
          prompt = "#loonsszjer-choice",
          -- all_choices = all_names,
        })
    local same=false 
    if to == player or room:askToChoice(player, {
          choices = choices,
          skill_name = loonsszjer.name,
          prompt = "#loonsszjer-choice",
          -- all_choices = all_names,
        }) ==choice then 
          same=true
    end
    if choice =="loonsszjer-play" then
      local play=function()
        local dat = { timeout = room:getBanner("Timeout") and room:getBanner("Timeout")[tostring(to.id)] or room.timeout }
        to.room.logic:trigger(fk.StartPlayCard, to, dat, true)

        local req = Request:new(to, "PlayCard")
        req.timeout = dat.timeout
        local result = req:getResult(to)
        if result == "" then return end

        local useResult = room:handleUseCardReply(to, result)  --useSkill useCard
        if type(useResult) == "table" then
          room:useCard(useResult)
        end
      end
      play()
      if not to.dead and same then play() end
    elseif choice =="loonsszjer-useAll" then
      while true do
        local use= room:askToUseRealCard(to, {
        pattern = cards,
        skill_name = loonsszjer.name,
        prompt = "#loonsszjer-use",
        skip=true,
        cancelable=false,
        extra_data = {
          bypass_times = true,
          extraUse = true,
          bypass_distances=true,
          expand_pile = to~=player and cards or nil,
        },
        })
        if use then 
          if same then
            use.disresponsiveList = table.simpleClone(room.players)
          end
          room:useCard(use)
          if to.dead then return end
          cards = table.filter(cards, function (id)
            return table.contains(player:getCardIds("h"),id)
          end)
          if #cards == 0  then  return end

        else
          return
        end
      end
    elseif choice =="loonsszjer-useOne" then
      local use= room:askToUseRealCard(to, {
      pattern = cards,
      skill_name = loonsszjer.name,
      prompt = "#loonsszjer-use",
      skip=true,
      cancelable=false,
      extra_data = {
        -- bypass_times = true,
        -- extraUse = true,
        -- bypass_distances=true
          expand_pile = to~=player and cards or nil,
      }})
      if use then 
        room:useCard(use)
        local n = same and 2 or 1
        if not player.dead then
          player:drawCards(n,loonsszjer.name)
        end
        if not to.dead then
          to:drawCards(n,loonsszjer.name)
        end
      end
    end

  end,
})

return loonsszjer
