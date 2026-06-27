local poavskvoeok = fk.CreateSkill {
  name = "poavskvoeok",
}

Fk:loadTranslationTable{
["poavskvoeok"] = "報國",
[":poavskvoeok"] = "➀當一其他角色受到傷害旹伱預打出x(x爲當轉伱發動此項次數)手牌發動,將此傷害轉与伱.➁當伱受到傷害後伱可發動,伱抽x(x爲伱已損體力值)",

["#poavskvoeok-invoke"]="報國  %src 傷害轉予伱",
["#poavskvoeok-choose"]="報國 打出 %arg 手牌將  %src 傷害轉予伱",
["#poavskvoeok-draw"]="報國 抽 %arg",

["$poavskvoeok1"] = "大丈夫爲國䀆忠 死而无憾",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

poavskvoeok:addAcquireEffect(function (self, player)
    player:addSkill("#poavskvoeok_draw") 
end)

poavskvoeok:addLoseEffect (function (self, player)
    player:loseSkill("#poavskvoeok_draw") 
end)


-- poavskvoeok:addEffect(fk.Damaged, {
--   anim_type = "masochism",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(poavskvoeok.name) 
--   end,
--   on_cost= function(self, event, target, player, data)
--      return 
--      player.room:askToSkillInvoke(player, {
--       skill_name = poavskvoeok.name,
--       prompt = "#poavskvoeok-draw:::"..player:getLostHp()
--     }) 
--   end,
--   on_use = function(self, event, target, player, data)
--         -- local n=player:usedEffectTimes(self.name, Player.HistoryTurn)
--     player:drawCards(player:getLostHp(), poavskvoeok.name)

--     -- if player:usedSkillTimes(poavskvoeok.name, Player.HistoryTurn) ==1 then --on_use 後
--     -- player:drawCards(1, poavskvoeok.name)--  --抽1
--     -- end
--   end,
-- })

poavskvoeok:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return (target ~= player) and player:hasSkill(poavskvoeok.name) 
    and not player:isKongcheng() 
  end,
  on_cost = function(self, event, target, player, data)
    local n=player:usedEffectTimes(self.name, Player.HistoryTurn)
    if n==0 then 
      if 
      player.room:askToSkillInvoke(player, {
      skill_name = poavskvoeok.name,
      prompt = "#poavskvoeok-invoke:"..data.to.id,
    }) then
      event:setCostData(self,{tos={data.to}})
      return true
      end
    else
      local cards=player.room:askToCards(player,{
        min_num=n,
        max_num=n,
        include_equip=false,
        pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
          return  not player:prohibitResponse(Fk:getCardById(id))
        end
        ) }),
        prompt = "#poavskvoeok-choose:"..data.to.id.."::"..n, 
        cancelable = true,
      })
      if #cards==n then
      event:setCostData(self, {tos={data.to},cards = cards})
      return true
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- room:addPlayerMark(player,"_poavskvoeok",1)
    local cards = event:getCostData(self).cards
    if cards then
      -- local card=Fk:cloneCard("khouc")
      -- card:addSubcards(event:getCostData(self).cards)
      -- room:responseCard({
			-- 	card=card,
			-- 	from=player,
			-- 	attachedSkillAndUser={muteCard=true},
			-- })
      S.playCard(player,cards,poavskvoeok.name)
    end

    -- data:preventDamage()  --轉傷算免傷?
      -- room:damage{
      --   from = data.from,
      --   to = player,
      --   damage = data.damage,
      --   damageType = data.damageType,
      --   skillName = data.skillName,
      --   chain = data.chain,
      --   card = data.card,
      -- }
    data.to=player
    target = player
    -- room.logic:trigger(fk.DamageInflicted, player, data)
    -- data.prevented=true

    -- if player:usedSkillTimes(poavskvoeok.name, Player.HistoryTurn) ==1 then --on_use 後
    -- player:drawCards(1, poavskvoeok.name)--  --抽1
    -- end

    return true

  end,
})


  -- on_cost = function(self, event, target, player, data)
  --   local room = player.room
  --   local n=player:usedEffectTimes(self.name, Player.HistoryTurn)
  --   -- local n=player:getMark("_poavskvoeok")
  --   local yes, ret = room:askToUseActiveSkill(player, {
  --     skill_name = "discard_skill", 
  --     prompt = "#poavskvoeok-invoke:"..data.to.id.."::"..n, 
  --     cancelable = true, 
  --     extra_data = {
  --       num = n,
  --       min_num = n,
  --       include_equip = false,
  --       skillName = poavskvoeok.name,
  --       pattern = ".",
  --     }, 
  --     no_indicate = false,
  --     skip=true,

  --   })
  --   if yes then 
  --     event:setCostData(self, {cards = ret.cards})
  --     return true
  --   end
  -- end,
return poavskvoeok
