Fk:loadTranslationTable{
  ["ex__zzjinqthou"] = "神偸",
  [":ex__zzjinqthou"] = "其它脚色A段終旹,若A當段內得到牌,伱可將1牌轉化爲因敵爲資對A起動發動.",

  ["ex__zzjinqthou-use"] = "神偸 昰否將牌轉化爲因敵爲資對 %src 起動",

  ["$ex__zzjinqthou1"] = "夜靜穿牆過更㴱繞屋縣",
  ["$ex__zzjinqthou2"] = "玅手空空",
  ["$ex__zzjinqthou3"] = "探囊取物㑥如反掌",

}

local ex__zzjinqthou = fk.CreateSkill{
  name = "ex__zzjinqthou",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos"

ex__zzjinqthou:addEffect(fk.EventPhaseEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if target~=player and player:hasSkill(ex__zzjinqthou.name) 
    and data.phase>1 and target.phase<8
    and not player:isNude() 
    then
      if event:getCostData(self) then return true end

      local n = 0
      local e  = player.room.logic:getEventsOfScope(GameEvent.MoveCards, 1, function (e)
      for _, move in ipairs(e.data) do
        if move.to == target and table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea) then
                -- player:drawCards(5)
          for _, info in ipairs(move.moveInfo) do
            if move.from~=target or (info.fromArea ~= Card.PlayerHand and info.fromArea ~= Card.PlayerEquip) then
              n=n+1
              return true
            end
          end
        end
      end
        end, Player.HistoryPhase)
      
      if n>0 then
        event:setCostData(self,{trigger_able=true})
        return true
      end
    end
  end,
  on_cost = function(self, event, target, player, data)
    local cards=player:getHandlyIds(true)
    -- local cards=table.filter(player:getHandlyIds(true), function(cid)
    --         return Fk:getCardById(cid).color==Card.Black
    --         end)
    -- local pattern=tostring(Exppattern{ id = cards}) 
    local use = player.room:askToUseVirtualCard(player, {
      name = "snatch",
      skill_name = ex__zzjinqthou.name,
      prompt = "#ex__zzjinqthou-use:"..target.id,
      cancelable = true,
      extra_data = {
        must_targets = {target.id},
        exclusive_targets = {target.id},
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
      event:setCostData(self, {trigger_able=true, extra_data = use,tos={target} })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).extra_data)
  end,
})


return ex__zzjinqthou
