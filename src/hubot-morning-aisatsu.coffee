# Description:
#   Morning aisatsu by cron.
#
# Dependencies:
#   cron
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   Drunkar <drunkars.p@gmail.com>
#

cronJob = require('cron').CronJob

config =
  roomId: process.env.HUBOT_AISATSU_ROOM_ID
  locale: process.env.HUBOT_AISATSU_LOCALE
  people: JSON.parse(process.env.HUBOT_AISATSU_PEOPLE ? '[]')

MORNING_AISATSUES = [ \
'おはようございます',
'Yo',
'眠い',
'うんこ',
'汚い',
'流れ変わったな',
'お早うございますご主人様',
'そうだ
これは夢なんだ
ぼくは今まで永い夢を見ていたんだ
目を閉じてまた開いた時
ぼくはまだ12歳の少年の夏
起きたらラジオ体操に行って
朝ご飯を食べて涼しい午前中に宿題して
午後からおもいっきり遊ぶんだ
虫取り網を手に持って・・・',
'死',
'おはよう',
'サスケェ…',
'朝は最強'
]

module.exports = (robot) ->
  # *(sec) *(min) *(hour) *(day) *(month) *(day of the week)
  new cronJob('0 17 15 * * 1,2,3,4,5', () ->
    unless config.roomId?
      robot.logger.error 'process.env.HUBOT_AISATSU_ROOM_ID is not defined'
      return
    unless config.locale?
      robot.logger.error 'process.env.HUBOT_AISATSU_LOCALE is not defined'
      return
    unless config.people?
      robot.logger.error 'process.env.HUBOT_AISATSU_PEOPLE is not defined'
      return

    aisatsu = msg.random MORNING_AISATSUES
    person = msg.random config.people
    robot.send config.roomId, person + ' ' + aisatsu, null, true, config.locale
  ).start()
