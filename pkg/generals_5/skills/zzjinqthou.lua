Fk:loadTranslationTable{
  ["zzjinqthou"] = "神偸",
  [":zzjinqthou"] = "當轉角色獲得牌後,伱可將1牌轉化爲｢因敵爲資｣對其使用發動.",

  ["#zzjinqthou-use"] = "神偸 昰否將黑牌轉化爲因敵爲資對 %src 使用",

  ["$zzjinqthou1"] = "夜靜穿牆過更㴱繞屋縣",
  ["$zzjinqthou2"] = "玅手空空",
  ["$zzjinqthou3"] = "探囊取物㑥如反掌",

}

local zzjinqthou = fk.CreateSkill{
  name = "zzjinqthou",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos"
local spec={
  on_cost = function(self, event, target, player, data)
    local cards=player:getHandlyIds(true)
    local to=event:getCostData(self).tos[1]
    local use = player.room:askToUseVirtualCard(player, {
      name = "hqjin_deek_qwe_tsji",
      skill_name = zzjinqthou.name,
      prompt = "#zzjinqthou-use:"..to.id,
      cancelable = true,
      extra_data = {
        must_targets = {to.id},
        exclusive_targets = {to.id},
        bypass_distances = false,  --🫨
        bypass_times = true,
      },
      card_filter = {
        n = 1,
        pattern=".|.|.",
        -- cards = cards,
      },
      skip = true,
    })
    if use then
      event:setCostData(self, { extra_data = use,tos={to} })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).extra_data)
  end,
}

zzjinqthou:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not event:getCostData(self) then  --refresh
      local current = Fk:currentRoom():getCurrent()  --需于事件旹記錄current
      if current==nil then 
        event:setCostData(self,{tos=nil})
        return
      end

      for _, move in ipairs(data) do
        if move.to  == current
          and table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)  
        then
          for _, info in ipairs(move.moveInfo) do
            if not (move.from==player and table.contains({Card.PlayerEquip,Card.PlayerHand }, info.fromArea) ) then
              event:setCostData(self,{tos={current}})
              break
            end
          end


        end
      end

    end
    
    return event:getCostData(self) 
    and event:getCostData(self).tos~=nil
    and event:getCostData(self).tos[1]
    and event:getCostData(self).tos[1]~=player 
    and player:hasSkill(zzjinqthou.name)  
    and not player:isKongcheng()
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})

-- zzjinqthou:addEffect(fk.EventPhaseStart, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     return target~=player and player:hasSkill(zzjinqthou.name) and target.phase == Player.Judge
--     and not player:isNude()
--   end,
--   on_cost=spec.on_cost,
--   on_use=spec.on_use,
-- })


return zzjinqthou
