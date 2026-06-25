local pujqjjem = fk.CreateSkill{
  name = "pujqjjem",
  tags = { Skill.Compulsory },
}


Fk:loadTranslationTable{
  ["pujqjjem"] = "飛檐",
  [":pujqjjem"] = "鎖定.恆續效果.若牌有距離限制(不含攻程限制),伱不是其合理目幖,伱使其无視距離",
}
--{因敵爲資/斷糧絕緣/行刺/偸樑換柱}
local cards={"hqjin_deek_qwe_tsji", "tvoans_liac_dzyet_quan", "hzaac_tshjes","thou_liac_hzvoans_dduoh","szyih_kouc"}

pujqjjem:addEffect("prohibit", {
is_prohibited = function(self, from, to, card)
    return card and to:hasSkill(pujqjjem.name) 
        and card.skill and card.skill.distance_limit 
    -- and table.contains(cards, card.trueName)
end,
})


pujqjjem:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card 
    and card.skill and card.skill.distance_limit 
    --and player:hasSkill(pujqjjem.name) and table.contains(cards, card.trueName)
  end,
})

return pujqjjem
