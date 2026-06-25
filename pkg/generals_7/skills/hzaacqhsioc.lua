local hzaacqhsioc = fk.CreateSkill({
  name = "hzaacqhsioc",
  attached_skill_name = "hzaacqhsioc_active&",
})

Fk:loadTranslationTable{
  ["hzaacqhsioc"] = "行凶",
  [":hzaacqhsioc"] = "➀恆續伱至體力值不大于1者距離爲1.➁每段限1.其它角色可于其主旹預將2黑手牌交予伱,選擇伱攻程內1角色A發動發動.視爲伱對A使用行刺。",

  -- ["hzaacqhsioc_active&"] = "買凶",
  -- [":hzaacqhsioc_active&"] = "段限1.交与行凶角色2黑手牌,其視爲使用行刺",

  -- ["#hzaacqhsioc_active"] = "買凶：選擇2手牌与行凶角色与行刺目幖",
  
  ["$hzaacqhsioc1"] = "挐人錢財与人消災",
  ["$hzaacqhsioc2"] = "伱止給足銀子明日自來与它收屍",
}

-- hzaacqhsioc:addAcquireEffect(function (self, player)
--   local room = player.room
--   for _, p in ipairs(room:getOtherPlayers(player, false)) do
--       room:handleAddLoseSkills(p, "hzaacqhsioc_active&", nil, false, true)
--   end
-- end)
hzaacqhsioc:addEffect(fk.GameStart, {
    can_refresh = Util.FalseFunc,
})
-- hzaacqhsioc:addLoseEffect(function (self, player)
--     local room = player.room

--       for _, p in ipairs(room:getOtherPlayers(player, false)) do
--         if not p.dead and p:hasSkill(hzaacqhsioc) then
--            return
--         end
--       end
      
--     for _, p in ipairs(room:getOtherPlayers(player, false)) do
--       room:handleAddLoseSkills(p, "-hzaacqhsioc_active&", nil, false, true)
--   end
-- end)

hzaacqhsioc:addEffect("distance", {
  fixed_func = function(self, from, to)
    if from:hasSkill(hzaacqhsioc.name) and to.hp<2 then
      return 1
    end
  end,
})

return hzaacqhsioc
