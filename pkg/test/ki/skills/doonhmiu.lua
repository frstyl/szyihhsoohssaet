local doonhmiu = fk.CreateSkill{
  name = "doonhmiu",
}

Fk:loadTranslationTable{
  ["doonhmiu"] = "盾矛",
  [":doonhmiu"] = "其它脚色起動｢殺｣對唯一目幖生效前,若伱{无/有}同花盾矛牌,伱可{發動,此殺无效,若其非轉化伱將其置于伱武將牌作爲盾矛牌/將同花盾矛牌轉化爲殺无視距離次數起動發動}",

  ["#doonhmiu-invoke"] = "盾矛 %src 對 %dest 起動 %arg，牌發動",
  ["#doonhmiu_use"] = "盾矛 將 %arg 轉化爲殺起動",

  ["doonhmiu_miu"] = "盾矛",

  ["$doonhmiu1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$doonhmiu2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

doonhmiu:addEffect(fk.PreCardEffect, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(doonhmiu.name)
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
      for _, id in ipairs(player:getPile("doonhmiu_miu")) do
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
        skill_name = doonhmiu.name,
        prompt = "#doonhmiu-invoke:"..data.from.id..":"..data.to.id..":"..data.card:toLogString(),
        }) 
      then
        event:setCostData(self,{tos={target}})
        return true
      end
    else
      local use = player.room:askToUseVirtualCard(player, {
        name = "ssaet",
        skill_name = doonhmiu.name,
        prompt = "#doonhmiu-use:"..Fk:getCardById(cards[1]):toLogString(),
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
      S.effectNullify(data)
      if not player.dead and not data.card:isVirtual() and room:getCardArea(data.card) == Card.Processing then
        player:addToPile("doonhmiu_miu", data.card, true, doonhmiu.name)
      end

    end

  end,
})




return doonhmiu
