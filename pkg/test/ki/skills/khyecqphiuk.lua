local khyecqphiuk = fk.CreateSkill {
  name = "khyecqphiuk",
}

Fk:loadTranslationTable{
  ["khyecqphiuk"] = "傾覆",
  [":khyecqphiuk"] = "主旹,伱可選擇1至2其它脚色(保畱選旹序)發動.伱与目幖脚色依伱選旹序各餘未選項中選擇1至x項(x=餘項數-待作選擇脚色數),肰後依項序檢查全部項序,若有脚色選擇之則其執行之.選項➀展示全部手牌弃置其中閃(无牌亦可選)➁弃裝僃區全部牌(无牌亦可選)➂發動者予伱1傷",

  ["khyecqphiuk-active"] = "傾覆 選擇1至2項執行 令其它脚色執行餘項",
  ["khyecqphiuk_szjemh"] = "展示全部手牌弃置其中閃(无牌亦可選)",
  ["khyecqphiuk_equip"] = "弃裝僃區全部牌(无牌亦可選)",
  ["khyecqphiuk_damage"] = "發動者予伱1傷",
}
khyecqphiuk:addEffect("active", {
  anim_type = "offensive",
  prompt = "#khyecqphiuk-active",
  max_phase_use_time = 1,
  card_num = 0,
  min_target_num = 1,
  max_target_num = 2,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and not player:prohibitDiscard(to_select)
  -- end,
  -- interaction = function(self, player)
  --   local choices = {}
    
  --   return UI.ComboBox { choices = choices , all_choices = {"khyecqphiuk_szjemh","khyecqphiuk_equip", "khyecqphiuk_damage", } }
  -- end,
  target_filter = function(self, player, to_select, selected)
    return #selected <2 and to_select~=player
  end,
  on_use = function(self, room, effect)
    
    local execute = function(p,wtf)
      if  p.dead then return end
      if wtf=="khyecqphiuk_szjemh"  then
          local cards=p:getCardIds("h")
          p:showCards(cards)
          cards=table.filter(cards,function(id)
            return Fk:getCardById(id).trueName == "szjemh" --and not to:prohibitDiscard(id)
          end)
        room:throwCard(cards,khyecqphiuk.name,p,p)
      end
      if  p.dead then return end
      if  wtf=="khyecqphiuk_equip"  then
        room:throwCard(p:getCardIds"e",khyecqphiuk.name,p,p)
      end
      if  p.dead then return end
      if  wtf=="khyecqphiuk_damage"  then
            room:damage{
              from = player,
              to = p,
              damage = 1,
              damageType = fk.NormalDamageDamage,
              skillName = khyecqphiuk.name,
            }
      end
    end

    local player = effect.from
    local all_choices = {"khyecqphiuk_szjemh","khyecqphiuk_equip", "khyecqphiuk_damage", }
    local choices = {"khyecqphiuk_szjemh","khyecqphiuk_equip", "khyecqphiuk_damage", }
    local chooser={}

    chooser["khyecqphiuk_szjemh"]=0  --???
    chooser["khyecqphiuk_equip"]=0
    chooser["khyecqphiuk_damage"]=0

    local n=#choices - #effect.tos
    local choose=room:askToChoices(player,{
      choices=choices,
      skill_name=khyecqphiuk.namen,
      prompt="khyecqphiuk-active",
      all_choices=all_choices,
      cancelable=false,
      min_num=1,
      max_num=n,
    })
    for _, str in ipairs(choose) do
      chooser[str]=player.id
      table.removeOne(choices,str)
    end

    for i, p in ipairs(effect.tos) do
      n=#choices -#effect.tos +i 
       choose=room:askToChoices(p,{
        choices=choices,
        skill_name=khyecqphiuk.namen,
        prompt="khyecqphiuk-active",
        all_choices=all_choices,
        cancelable=false,
        min_num=1,
        max_num=n,
      })
      for _, str in ipairs(choose) do
        chooser[str]=p.id
        table.removeOne(choices,str)
      end
    end

    for _, str in ipairs(all_choices) do
      execute(room:getPlayerById(chooser[str]),str)
    end

  end,
})

return khyecqphiuk
