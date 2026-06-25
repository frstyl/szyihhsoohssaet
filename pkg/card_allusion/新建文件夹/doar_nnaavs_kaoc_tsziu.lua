Fk:loadTranslationTable{
  ["doar_nnaavs_kaoc_tsziu"] = "大鬧江州",
  [":doar_nnaavs_kaoc_tsziu"] = "任一末段始旹,若其下家A有牢或伏區有延旹錦囊,伱可預弃1殺或武器牌發動.下家迻去全部牢与伏區延旹錦囊",

  ["#doar_nnaavs_kaoc_tsziu"] = "大鬧江州 是否解救%src",
 
  -- ["$doar_nnaavs_kaoc_tsziu1"] = "我等在此堅守戒僃",
  -- ["$doar_nnaavs_kaoc_tsziu2"] = "昰後路早就安排妥當",
}

local doar_nnaavs_kaoc_tsziu = fk.CreateSkill{
  name = "doar_nnaavs_kaoc_tsziu",
}

doar_nnaavs_kaoc_tsziu:addEffect("cardskill", {  --歬轉終
  prompt = "#doar_nnaavs_kaoc_tsziu",
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card)
    return to_select ~= player and
    to_select:getMark("loav")>0
  end,
  target_filter = Util.CardTargetFilter,
  on_effect = function(self, room, effect)
    room:setPlayerMark(effect.to,"loav",0)
  end,
})


return doar_nnaavs_kaoc_tsziu
