local hzoanskaak = fk.CreateSkill{
  name = "hzoanskaak",
}

Fk:loadTranslationTable{
  ["hzoanskaak"] = "扞挌",--zzyinh
  [":hzoanskaak"] = "其它脚色起動｢殺｣對僅存目幖生效前,若伱无同色扞挌牌,伱可發動,此次起動對目幖无效,若其非轉化伱將其置于伱武將牌作爲扞挌牌;有同色扞挌牌,伱可將同花扞挌牌轉化爲殺起動(无視距離次數)發動",

  ["#hzoanskaak-invoke"] = "扞挌 %src 對 %dest 起動 %arg 是否發動",
  ["#hzoanskaak_use"] = "扞挌 將 %arg 轉化爲殺起動",

  ["hzoanskaak_miu"] = "扞挌",

  ["$hzoanskaak1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$hzoanskaak2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzoanskaak:addEffect(fk.PreCardEffect, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(hzoanskaak.name)
    and 
    data:isOnlyTarget(data.to)
    and data.from~=player
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room

    local include=false
    local cards={}
    if data.card.suit==Card.NoSuit then
      include=false
    else
      for _, id in ipairs(player:getPile("hzoanskaak_miu")) do
        if Fk:getCardById(id).suit==data.card.suit then
          include=true
          cards={id}
          break
        end
      end
    end
    
    if not include then 
      if 
      player.room:askToSkillInvoke(player, {
        skill_name = hzoanskaak.name,
        prompt = "#hzoanskaak-invoke:"..data.from.id..":"..data.to.id..":"..data.card:toLogString(),
        }) 
      then
        event:setCostData(self,{tos={data.to}})
        return true
      end
    else
      local use = player.room:askToUseVirtualCard(player, {
        name = "ssaet",
        skill_name = hzoanskaak.name,
        prompt = "#hzoanskaak-use:"..Fk:getCardById(cards[1]):toLogString(),
        extra_data = {
          bypass_distances = true,
          bypass_times = true,
          extraUse=true,
        },
        expand_pile=cards,
        subcards=cards,
        cancelable = true,
        skip = true,
      })
      if use then 
        event:setCostData(self,{use=use,tos=use.tos})
        return true
      end
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room


    if event:getCostData(self).use then
      room:useCard(event:getCostData(self).use)
    else
      S.effectNullify(data,player,hzoanskaak.name,true)
      if not player.dead and not data.card:isVirtual() and room:getCardArea(data.card) == Card.Processing then
        player:addToPile("hzoanskaak_miu", data.card, true, hzoanskaak.name)
      end

    end

  end,
})




return hzoanskaak
