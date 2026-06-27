local likbvoat = fk.CreateSkill{
  name = "likbvoat",
}

Fk:loadTranslationTable{
  ["likbvoat"] = "力拔",
  [":likbvoat"] = "伱使用殺對目幖致傷旹,若目幖有手牌,伱可發動.伱展示目幖全部手牌,伱可流失1體力執行1項,或再減1體力上限執行2項➀伱獲得其中酒肉,➁伱弃置其中非基本,此殺傷害值+所弃牌數",

  ["#likbvoat-choose"] = "流失1體力執行1項 ",
  ["likbvoat-get"] = "獲得桃酒",
  ["likbvoat-discard"] = "弃置非基本",
  ["likbvoat-both"] = "減1體力上限 執行2項",

  ["$likbvoat"] = "打甚鳥緊,看洒家之",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

likbvoat:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(likbvoat.name) 
      and data.card and data.card.trueName=="ssaet"
      and player.room.logic:damageByCardEffect()  --轉迻傷害可行
      and not data.to:isKongcheng()
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to=data.to

    if to.dead  or player.dead  then return end

    local cards=to:getCardIds("h")
    to:showCards(cards)
    local get={}
    local throw={}
    for _,cid in ipairs(cards) do
      card=Fk:getCardById(cid)
      if card.trueName=="nziuk" or card.trueName=="tsiuh" then
        table.insert(get,cid)
      elseif S.getCardTypeByName(card.trueName)~=1 then
        table.insert(throw,cid)
      end
    end
    choice = room:askToChoice(player, {
      choices = {"likbvoat-get","likbvoat-discard","likbvoat-both","Cancel"},
      skill_name = likbvoat.name,
      prompt = "#likbvoat-choose" 
     })
    if choice == "Cancel" then return end
    room:loseHp(player, 1,likbvoat.name)

    -- if to.dead  or player.dead then return end

    if choice == "likbvoat-both" then     
      room:changeMaxHp(player, -1)     
      -- if to.dead  or player.dead then return end 
    end
    
    if choice ~= "likbvoat-discard" then --中塗抽牌不計入
      if player.dead then room:throwCard(get, likbvoat.name, to, player) 
      else
        room:obtainCard(player, get, false, fk.ReasonPrey, player, likbvoat.name)
      end
    end

    if choice == "likbvoat-get" then return end

    room:throwCard(throw, likbvoat.name, to, player)  --新來者不計

    S.changeDamage({damageData=data,num=#throw,skillName=likbvoat.name})
  end,
})



return likbvoat
