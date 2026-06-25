local biussjins = fk.CreateSkill({
  name = "biussjins",  --法則技?
  tags = { Skill.Compulsory, Skill.Combo},
})

Fk:loadTranslationTable{
  ["biussjins"] = "覆訊",
  [":biussjins"] = "鎖定.任一角色聲明使用牌後,記錄所用牌花色.當一角色使用耦數張牌旹,若此牌无色或其花色含于記錄,此使用无效,中止當段",


  ["#biussjins-card"] = "覆訊：%dest 使用 %arg 伱可令其无效",
  ["@biussjins_suit-phase"] = "覆訊",
  -- ["#biussjins-damage"] = "覆訊：伱受到 %arg 傷害 伱可弃1同花色牌發防止傷害",

  ["$biussjins1"] = "伱昰太乙三才陣何足爲奇",
  ["$biussjins2"] = "九宮八卦已无敵,河洛四像眞堪奇",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

-- biussjins:addEffect(fk.EventPhaseStart, {
--   can_refresh = function (self, event, target, player, data)
--     return player:hasSkill(biussjins.name)  
--     and target~=player
--     and target.phase == Player.Play 
--   end,
--   on_refresh = function (self, event, target, player, data)
--       player.room:setPlayerMark(target,"biussjins_start-phase",1)
--   end,
-- })

-- biussjins:addEffect(fk.CardUsing, {
--   anim_type = "control",
--   can_trigger = function(self, event, target, player, data)
--     return 
--       target~=player and player:hasSkill(biussjins.name)
--       and data.extra_data and data.extra_data.combo_skill and data.extra_data.combo_skill[biussjins.name]
--   end,
--   on_cost = function(self, event, target, player, data)
--     return player.room:askToSkillInvoke(player,{
--           skill_name = biussjins.name,
--           prompt = "#biussjins-card::" .. target.id .. ":" .. data.card:toLogString(),
--           })
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     room:setPlayerMark(target,"@biussjins_suit-phase",0)
--     if not target:canPindian(player) or not room:askToSkillInvoke(target,{
--           skill_name = biussjins.name,
--           prompt = "#biussjins-pindian::" .. player.id .. ":" .. data.card:toLogString(),
--           }) then 
--       data.nullified=true
--     else
--           local pindian = target:pindian({player}, biussjins.name)
--         if  pindian.results[player].winner == player then
--           data.nullified=true
--           room:askToDiscard(target, {
--             min_num = 1,
--             max_num = 1,
--             include_equip = true,
--             skill_name = biussjins.name,
--             cancelable = false,
--             pattern = ".",
--             prompt = "#kvoanqddxins-discard",
--             skip = false,
--           })
--         end
--     end

--   end,
-- })

biussjins:addEffect(fk.CardUsing, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return 
      target==player 
      and data.extra_data and data.extra_data.combo_skill and data.extra_data.combo_skill[biussjins.name]
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
      S.useNullify(data,nil,biussjins.name)
      player:endCurrentPhase()
  end,
})

biussjins:addEffect(fk.AfterCardUseDeclared, {
  can_refresh = function (self, event, target, player, data)
    return target == player 
    --and player:getMark("biussjins_start-phase")>0
  end,
  on_refresh = function (self, event, target, player, data)
    local room=player.room
    -- local suits =player:getMark("@biussjins_suit-phase")
    -- local newSuits={}
    -- local n =#suits
    -- if n>3 then
    --   for i=#suits-2, n,1 do
    --     newSuits[i]=suits[i]
    --   end
    -- else
    --   newSuits=suits
    -- end
    -- table.insert(newSuits,data.card:getSuitString(true))
    -- room:setPlayerMark(player,"@biussjins_suit-phase",newSuits)
    local suit =data.card:getSuitString(true)
    local suits=player:getTableMark("@biussjins_suit-phase")
    if  #suits%2==1
    and 
    (data.card.suit== Card.NoSuit 
    or
    table.find(suits,function(i)
    return  suit==i
    end)
    )
      -- (for _, s in ipairs(player:getTableMark("@biussjins_suit-phase")) do
      --   if s==suit then
      --     return true
      --   end
      -- end)
    then 
      data.extra_data = data.extra_data or {}
      data.extra_data.combo_skill = data.extra_data.combo_skill or {}
      data.extra_data.combo_skill[biussjins.name] = true
    end
    table.insert(suits,suit)
    room:setPlayerMark(player,"@biussjins_suit-phase",suits)
  end,
})

return biussjins
