local likbvoat = fk.CreateSkill{
  name = "likbvoat",
}

Fk:loadTranslationTable{
  ["likbvoat"] = "力拔",
  [":likbvoat"] = "伱指定｢殺｣目幖後,伱可聲明1數字發動｡伱流失1,展示目幖全部手牌,若其行動牌數比于伱聲明數(較大/較小/相同},伱弃置其中行動牌/伱弃置其中非行動非物資牌/取得酒肉或弃置非物資牌｡選牌合計至多((1+目幖手牌數)整除2),因此每1弃置非行動物資質牌傷害基數+1",
  -- [":likbvoat"] = "伱起動殺對目幖致傷旹,若目幖有手牌,伱可發動.伱展示目幖全部手牌,伱可流失1執行1項,或再減1體力上限執行2項➀伱取得其中酒肉,➁伱弃置其中非行動牌,此殺傷害值+所弃牌數",

  ["#likbvoat-invoke"] = "力拔 對 %dest 發動 聲明1數字",

  -- ["#likbvoat-choose"] = "流失1執行1項 ",
  -- ["likbvoat-get"] = "取得桃酒",
  -- ["likbvoat-discard"] = "弃置非行動牌",
  -- ["likbvoat-both"] = "減1體力上限 執行2項",

  ["$likbvoat"] = "打甚鳥緊,看洒家之",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


likbvoat:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(likbvoat.name) 
      and data.card and data.card.trueName=="ssaet"
  end,
  on_cost = function(self, event, target, player, data)
      local choices = {}
      for i=0, 99, 1 do
        table.insert(choices, tostring(i))
      end
      number = player.room:askToChoice(player, { ---@type integer
        choices = choices,
        skill_name = likbvoat.name,
        prompt = "#likbvoat-invoke::" .. data.to.id,
        cancelable=true,
      })
      if number~="Cancel" then
        event:setCostData(self,{tos={data.to},extra_data=tonumber(number)})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to=data.to
    room:loseHp(player,1,self.name,player)

    local cards=to:getCardIds("h")
    to:showCards(cards)
    if to.dead  or player.dead  then return end

    local newCards=to:getCardIds("h")
    cards=table.filter(cards,function(id) return table.contains(newCards,id)end)

    local     nziuk , throw, act={}, {}, {}
    for _, id in ipairs(cards) do
      local name = Fk:getCardById(id).trueName
      if table.contains({"nziuk","tsiuh"}, name)  then
        table.insert(nziuk,id)
      else
        local ty= S.getCardTypeByName(name)
        if ty==1 then
          table.insert(act,id)
        elseif  ty~=4 then
          table.insert(throw,id)
        end
      end 
    end

    local card_data={}
    if event:getCostData(self).extra_data==#act then
      card_data= {  {"act", act },
          {"throw", throw },
          { "nziuk", nziuk },}
    elseif event:getCostData(self).extra_data<#act then
      card_data={  {"act", act }}
    else
      card_data={  {"throw", throw }}

    end
    choosed = room:askToChooseCards( player, {
        target = target,
        min = 0,
        max = (#newCards+1)//2,
        -- flag = "he",
        flag = { card_data = card_data,
        skill_name = likbvoat.name,
        prompt = "#likbvoat-choose",
      }
    })
    
    if #choosed==0 then return end


    throw=table.filter(throw, function(id) return table.contains(choosed, id) end)
    act=table.filter(act, function(id) return table.contains(choosed, id) end)
    nziuk=table.filter(nziuk, function(id) return table.contains(choosed, id) end)

    local moveInfos={}
    if #nziuk>0 then
      table.insert(moveInfos, {
        from = to.id,
        ids = nziuk,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonPrey,
        proposer = player,
        to=player,
        skillName = likbvoat.name,
      })
    end
    if #throw>0 then
      table.insert(moveInfos, {
        from = to.id,
        ids = throw,
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonDiscard,
        proposer = player,
        skillName = likbvoat.name,
      })
    end
    if #act>0 then
      table.insert(moveInfos, {
        from = to.id,
        ids = act,
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonDiscard,
        proposer = player,
        skillName = likbvoat.name,
      })
    end
      room:moveCards(table.unpack(moveInfos))
    if #throw>0 then
       data.additionalDamage=(data.additionalDamage or 0)+#throw
    end
  end,
})




-- likbvoat:addEffect(fk.DamageInflicted, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return data.from == player and player:hasSkill(likbvoat.name) 
--       and data.card and data.card.trueName=="ssaet"
--       and player.room.logic:damageByCardEffect()  --轉迻傷害可行
--       and not data.to:isKongcheng()
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     local to=data.to

--     if to.dead  or player.dead  then return end

--     local cards=to:getCardIds("h")
--     to:showCards(cards)
--     local get={}
--     local throw={}
--     for _,cid in ipairs(cards) do
--       card=Fk:getCardById(cid)
--       if card.trueName=="nziuk" or card.trueName=="tsiuh" then
--         table.insert(get,cid)
--       elseif S.getCardTypeByName(card.trueName)~=1 then
--         table.insert(throw,cid)
--       end
--     end
--     choice = room:askToChoice(player, {
--       choices = {"likbvoat-get","likbvoat-discard","likbvoat-both","Cancel"},
--       skill_name = likbvoat.name,
--       prompt = "#likbvoat-choose" 
--      })
--     if choice == "Cancel" then return end
--     room:loseHp(player, 1,likbvoat.name,player)

--     -- if to.dead  or player.dead then return end

--     if choice == "likbvoat-both" then     
--       room:changeMaxHp(player, -1)     
--       -- if to.dead  or player.dead then return end 
--     end
    
--     if choice ~= "likbvoat-discard" then --中塗抽牌不計入
--       if player.dead then room:throwCard(get, likbvoat.name, to, player) 
--       else
--         room:obtainCard(player, get, false, fk.ReasonPrey, player, likbvoat.name)
--       end
--     end

--     if choice == "likbvoat-get" then return end

--     room:throwCard(throw, likbvoat.name, to, player)  --新來者不計

--     S.changeDamage({damageData=data,num=#throw,skillName=likbvoat.name})
--   end,
-- })



return likbvoat
