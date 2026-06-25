local kheenqsjens = fk.CreateSkill {
  name = "kheenqsjens",
  attached_skill_name = "kheenqsjens_active&",
}

Fk:loadTranslationTable {
  ["kheenqsjens"] = "牽線",
  [":kheenqsjens"] = "階段限1.其它角色A于其主旹可預將1梅花手牌交予与伱併選1角色B除伱与其己者發動.B可交予伱1梅花手牌",

  ["#kheenqsjens-failed"] = "%from 与 %to 牽手失敗",
  ["#kheenqsjens-successed"] = "%from 与 %to 牽手成功",

  ["$kheenqsjens1"] = "昰事兒交給乾娘我已",
  ["$kheenqsjens2"] = "喫个合和湯如何",
}

-- kheenqsjens:addEffect(fk.GameStart, {  --占位
--     can_refresh = Util.FalseFunc,
-- })
local S = require "packages/szyihhsoohssaet/szyih_guos" 

local sig=function(n)
  if n==0 then 
    return 0
  elseif n>0 then 
    return 1
  elseif n<0 then 
    return -1
  end
end
kheenqsjens:addEffect("active", {
  anim_type = "support",
  prompt = "#kheenqsjens&",
  mute = true,
  card_num = 1,
  target_num = 2,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  -- end,
  card_filter = function(self, player, to_select, selected)
    return #selected < 1 and Fk:getCardById(to_select).type == Card.TypeTrick  -- 
  end,
  target_filter = function(self, player, to_select, selected)
    return to_select ~= player 
    and(
      #selected == 0  
  )
    or (
      #selected==1
      and sig(selected[1].hp -selected[1]:getHandcardNum())~=sig(to_select.hp-to_select:getHandcardNum())
    )
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    if effect.cards and #effect.cards>0 then
      room:throwCard(effect.cards,kheenqsjens.name,player,player)
    end
    local yes=true
    for _, target in ipairs(effect.tos) do
      if not target.dead then 
        local card=room:askToCards(target, {
              min_num = 1,
              max_num = 1,
              include_equip = false,
              skill_name = kheenqsjens.name,
              pattern = ".|.|club",
              prompt = "#kheenqsjens-choose",
              cancelable = true,
            })
        if #card>0 then
          room:moveCardTo(card, Player.Hand, target, fk.ReasonGive, "kheenqsjens", nil, true, player)  --牽線成功
          
          S.deControl(target,"kheenqsjens", player)
        else  --kiaploav
          room:addPlayerMark(target,"@loav",1)
          yes=false
        end
      end
    end

    if not yes then  
       player.room:sendLog{ type = "#kheenqsjens-failed", from = effect.tos[1].id, to = {effect.tos[2].id} }
      return 
    end

         player.room:sendLog{ type = "#kheenqsjens-successed", from = effect.tos[1].id, to = {effect.tos[2].id }}

      for _, target in ipairs(effect.tos) do
        if not target.dead then 
          local choices = {"draw2"}
          if target:isWounded() then
            table.insert(choices, "recover")
          end
          local choice = room:askToChoice(target, {
            choices = choices,
            skill_name = kheenqsjens.name,
          })
          if choice == "draw2" then
            target:drawCards(2, kheenqsjens.name)
          else
            room:recover({
              who = target,
              num = 1,
              recoverBy = player,
              skillName = kheenqsjens.name
            })
          end
        end
      end

  end,
})

return kheenqsjens
