local skill = fk.CreateSkill {
  name = "theet_soak_skill",
}


Fk:loadTranslationTable{
  ["theet_soak_skill"] = "鐵索",
  ["#theet_soak_skill"] = "鐵索",
  ["@@theet_soak"] = "共濟",
}

skill:addEffect("cardskill", {
  prompt = "#theet_soak_skill",
  min_target_num = 1,
  max_target_num = 2,
  mod_target_filter = Util.TrueFunc,
  target_filter = Util.CardTargetFilter,
  on_effect = function(self, room, effect)
    to =effect.to
    if to:getMark("@@theet_soak")==1 then  --  --No setMark But getMark
    room:setPlayerMark(to,"@@theet_soak",0)  --分組?
    elseif to:getMark("@@theet_soak")==0  then
    room:setPlayerMark(to,"@@theet_soak",1)
    end
  end,
})

-- skill:addEffect("Damaged", {  --Damaged記錄連環者 新入chain者不受此chain傷
  -- global = true,
  -- can_refresh = function(self, event, target, player, data)
    -- return Fk:canChain(data.damageType) and data.to.getMark("@@theet_soak")>0 
  -- end,
  -- on_refresh = function(self, event, target, player, data)
  -- data.to:setMark(to,"@@theet_soak",0)  --觸發態
    -- if not data.chain then  --多餘
        -- data.beginnerOfTheDamage = true
	-- end
	-- data.chain_table = table.filter(room:getOtherPlayers(data.to), 
	-- function(p)
	-- return p:getMark("@@theet_soak")>0  --DamageData止有chain_table 一table
	-- end)
	
  -- end,
-- })

-- skill:addEffect("DamageFinished", {
  -- global = true,
  -- can_refresh = function(self, event, target, player, data)
	-- if data.chain_table and #data.chain_table > 0 then
		-- data.chain_table = table.filter(data.chain_table, function(p)
		  -- return p:isAlive() and p.chained
		-- end)
	-- end
		-- return #data.chain_table>0
	  -- end,
  -- on_refresh = function(self, event, target, player, data)
    -- for _, p in ipairs(data.chain_table) do
		-- if p:getMark("@@theet_soak")>0 then --區分連環是否爲同一組
		  -- room:sendLog{
			-- type = "#ChainDamage",
			-- from = p.id
		  -- }

		  -- local dmg = {
			-- from = data.from,
			-- to = p,
			-- damage = data.damage,
			-- damageType = data.damageType,
			-- card = data.card,
			-- skillName = data.skillName,
			-- chain = true,  --區別是否傳導 改爲傳導可觸發傳導
		  -- }
		  -- room:damage(dmg)
		-- end
    -- end
-- end,
-- })
return skill
