local tszjeqkeejs = fk.CreateSkill {
  name = "tszjeqkeejs",
}

Fk:loadTranslationTable{
  ["tszjeqkeejs"] = "支計",
  [":tszjeqkeejs"] = "任一角色額定抽牌歬,伱可選擇1項令其執行發動.➀本次抽牌數+1,當轉存牌數數-1➁本次抽牌數-1,當轉存牌數數+1(抽牌數已爲0則不可選)",  --額定手牌數改名

  ["#tszjeqkeejs-invoke"] = "%src 將抽牌 伱可選擇1項",
  ["#tszjeqkeejs_add"] = "令其多抽1 本輪額定手牌數-1",
  ["#tszjeqkeejs_minus"] = "令其少抽1 本輪額定手牌數+1",

  ["$tszjeqkeejs1"] = "餘糧甚厚",  --
}
tszjeqkeejs:addEffect(fk.DrawNCards, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tszjeqkeejs.name)
    end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local choices={ "#tszjeqkeejs_add", "#tszjeqkeejs_minus","Cancel"}
    if data.n<1 then choices={ "#tszjeqkeejs_add","Cancel"} end
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = tszjeqkeejs.name,
      prompt="#tszjeqkeejs-invoke:"..target.id
    })
    if choice ~="Cancel" then
      event:setCostData(self,{choice=choice})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    if event:getCostData(self).choice=="#tszjeqkeejs_add"  then
      data.n = data.n +1
      player.room:addPlayerMark(target, MarkEnum.MinusMaxCardsInTurn, 1)
    else
      data.n = data.n -1
      player.room:addPlayerMark(target, MarkEnum.AddMaxCardsInTurn, 1)
    end
  end,
})


return tszjeqkeejs
