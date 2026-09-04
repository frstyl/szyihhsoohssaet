local szuoqquns = fk.CreateSkill {
  name = "szuoqquns",
}

Fk:loadTranslationTable{
  ["szuoqquns"] = "輸運",
  [":szuoqquns"] = "➀伱補段始旹,伱可發動.伱將x牌置于伱將牌上(後來者在下)➁一脚色A主段執行旹,若伱有資伱可發動.1段內,A起動打出牌旹,若其大類或花与頂上張資相同,A取得該資.",  --淸理?
  -- [":szuoqquns"] = "➀伱補段始旹,若伱无資,伱可發動.伱亮出牌堆頂x牌,伱選其中0至多類花不全同者各1置于伱武將牌上,稱爲資,餘者置入弃牌堆➁一脚色A主段始旹,若伱有資伱可發動.1段內,該A起動打出牌旹,若其類或花与第一張資相同,A取得該資.",  --淸理?

  -- ["#szuoqquns-choose"] = "輸運 選0至多類花不全同者 自由排序",
  ["#szuoqquns-give"] = "輸運 %src主段,是否輸糧",
  ["@@szuoqquns-phase"] = "輸運",
  ["szuoqquns_tsji"] = "資",

  ["$szuoqquns1"] = "糧艸器械䀆在掌握之中",
  ["$szuoqquns2"] = "若何調度吾自有分寸",
  ["$szuoqquns3"] = "大軍未動糧艸先行",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- Fk:addPoxiMethod{
--   name = "szuoqquns",
--   card_filter = function(to_select, selected, data)
--     if table.contains(data[2], to_select) then return true end
--     local suit = Fk:getCardById(to_select).suit
--     local typ = S.getCardTypeByName(Fk:getCardById(to_select))
--     return table.every(data[2], function (id)
--       return Fk:getCardById(id).suit ~= suit 
--       or  S.getCardTypeByName(Fk:getCardById(id)) ~= typ
--     end)
--   end,
--   feasible = Util.TrueFunc,
-- }

szuoqquns:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(szuoqquns.name) and player.phase == Player.Draw 
    -- and #player:getPile("szuoqquns_tsji")==0
  end,
  on_use = function(self, event, target, player, data)
    -- data.phase_end = true
    local room = player.room
    local n =player.maxHp+player:getLostHp()-#player:getPile("szuoqquns_tsji")
    if n<=0 then return end
    local cards = room:getNCards(n)
    player:addToPile("szuoqquns_tsji", cards, true, szuoqquns.name,player)

    -- room:moveCards({
    --   ids = cards,
    --   toArea = Card.Processing,
    --   moveReason = fk.ReasonPrey,
    --   skillName = szuoqquns.name,
    --   proposer = player.id,
    -- })
    -- local get = {}
    -- for _, id in ipairs(cards) do
    --   local suit = Fk:getCardById(id).suit
    --   if table.every(get, function (id2)
    --     return Fk:getCardById(id2).suit ~= suit
    --   end) then
    --     table.insert(get, id)
    --   end
    -- end
    -- get = room:askToArrangeCards(player, {
    --   skill_name = szuoqquns.name,
    --   card_map = cards,
    --   prompt = "#szuoqquns-choose",
    --   free_arrange = false,
    --   box_size = 0,
    --   max_limit = {n, n},
    --   min_limit = {0, 0},
    --   poxi_type = "szuoqquns",
    --   default_choice = {{}, {}},
    -- })[2]
    -- if #get > 0 then
    --   player:addToPile("szuoqquns_tsji", get, true, szuoqquns.name)
    --   -- room:obtainCard(player, get, true, fk.ReasonPrey, player, szuoqquns.name)
    -- end
    -- room:cleanProcessingArea(cards)
  end,
})

szuoqquns:addEffect(fk.EventPhaseProceeding, {  --TurnStart ?
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target.phase==Player.Play and player:hasSkill(szuoqquns.name) and #player:getPile("szuoqquns_tsji") > 0 
  end,
  on_cost= function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      skill_name=szuoqquns.name,
      prompt="#szuoqquns-give:"..target.id
    })
  end,
  on_use = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@@szuoqquns-phase",target.id)
  end,
})


local spec = {
  can_trigger = function(self, event, target, player, data)
    return player:getMark("@@szuoqquns-phase") ==target.id 
	and  player:getPile("szuoqquns_tsji")[1]
    and (
      S.compareCardType(data.card,player:getPile("szuoqquns_tsji")[1], 3) 
     or data.card:compareSuitWith(Fk:getCardById(player:getPile("szuoqquns_tsji")[1]))
     )
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    player.room:obtainCard(target, player:getPile("szuoqquns_tsji")[1], true, fk.ReasonPrey, target, szuoqquns.name)
  end,
}

szuoqquns:addEffect(fk.CardUsing, spec)

szuoqquns:addEffect(fk.PreCardRespond, spec)

return szuoqquns
