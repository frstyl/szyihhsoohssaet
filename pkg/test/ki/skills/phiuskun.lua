local phiuskun = fk.CreateSkill {
  name = "phiuskun",
}

Fk:loadTranslationTable{
  ["phiuskun"] = "覆軍",
  [":phiuskun"] = "伱指定｢殺｣目幖後,伱可選擇目幖至多x牌(含將牌)發動,暗置之,1轉內目幖不可亮將",

  ["#phiuskun-invoke"] = "覆軍：你可以暗置 %dest 至多%arg张牌",

  ["@phiuskun"] = "覆軍",
  -- ["$phiuskun1"] = "奋身出命，为国建功！",
  -- ["$phiuskun2"] = "披甲持戟，先登陷陈！",
}

local H = require "packages.hegemony.util"
local S = require "packages/szyihhsoohssaet/szyih_guos" 

phiuskun:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(phiuskun.name) 
    and data.card.trueName == "ssaet" 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to =data.to
    local to_hands = table.filter(to:getCardIds("h"), function(id)
      return S.canSetVisible(id)
    end)
    local to_equips = table.filter(to:getCardIds("e"), function(id)
      return S.canSetVisible(id)
    end)
    local generals={}
          -- if H:hasGeneral(data.to) and to.general~="anjiang" then
            table.insert(generals, S.getKhouc(1, {"@phiuskun", to.general })[1]) 

          -- end
          if H:hasGeneral(data.to,true) then
          table.insert(generals, S.getKhouc(1, {"@phiuskun",  to.deputyGeneral})[1]) 
          end
    -- for _, k  in ipairs ({"m","d"}) do  --多將應該table
    --   if H:hasGeneral(data.to,k=="m") then
    --    table.insert(generals, S.getKhouc(1, {"@phiuskun", k=="m" and to.general or to.deputyGeneral})[1]) 
    --   end
    -- end
    local visible_data={}
    for _, id in ipairs(to_hands) do
      if not player:cardVisible(id) then
        visible_data[tostring(id)] = false --string??
      end
    end
    local cards = room:askToPoxi(player, {
      poxi_type = "AskForCardsChosen",
      data = {
          {"general_card", generals },
          {"$Hand", to_hands},
          {"$Equip", to_equips},
      },
      extra_data = {
        min = 1,  
        max = to.maxHp,
        skillName = phiuskun.name,
        prompt = "#phiuskun-invoke::"..data.to.id..":"..data.to.maxHp,
        visible_data=visible_data
      },
      cancelable = false,
    })

    local cards1 = table.filter(cards, function(id) return table.contains(generals, id) end)
    local cards2 = table.filter(cards, function(id) return table.contains(to_hands, id) end)
    local cards3 = table.filter(cards, function(id) return table.contains(to_equips, id) end)

    if #cards1>0 then
      local t= to:getTableMark(MarkEnum.RevealProhibited.."-turn")
      for _, id  in ipairs (cards1) do
        local d=Fk:getCardById(id):getMark("@phiuskun")==to.deputyGeneral
        table.insertIfNeed(t, d and "d" or "m")
        to:hideGeneral(d)
      end
      room:setPlayerMark(data.to,MarkEnum.RevealProhibited.."-turn")
    end

    if #cards2>0 then
      S.setCardsVisible(cards2,-1)
    end

    if #cards3>0 then
      S.setCardsVisible(cards3,-1)
    end
    end,
})

-- phiuskun:addEffect('invalidity', {
--   -- global = true,
--   invalidity_func = function(self, player, skill)
--     if not( skill:getSkeleton() 
--           and 
--             skill:getSkeleton().attached_equip 
--           )
--     then return end 
--     -- local name = skill:getSkeleton().attached_equip 
--     return not  S.hasEquip(player, skill:getSkeleton().attached_equip )
--   end,
-- })
return phiuskun
