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
  room: process.env.HUBOT_AISATSU_ROOM
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
  new cronJob('0 * * * * 1,2,3,4,5', () ->
    unless config.room?
      robot.logger.error 'process.env.HUBOT_AISATSU_ROOM is not defined'
      return
    unless config.people?
      robot.logger.error 'process.env.HUBOT_AISATSU_PEOPLE is not defined'
      return

    ai = Math.floor(Math.random() * MORNING_AISATSUES.length)
    pi = Math.floor(Math.random() * config.people.length)
    envelope = {room: config.room}
    robot.send envelope, config.people[pi] + ' ' + MORNING_AISATSUES[ai]
  ).start()
