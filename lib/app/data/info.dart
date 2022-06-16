final DateTime timeNow = DateTime.now();
final String hourAndMinute = '${timeNow.hour}:${timeNow.minute}';
final messages = [
  {"isMe": false, "text": "Bem vindo a Pet Hood!", "time": hourAndMinute},
  {
    "isMe": false,
    "text": "Este é apenas um preview do chat",
    "time": hourAndMinute
  },
  {"isMe": false, "text": "Ainda não implementamos :(", "time": hourAndMinute},
  {"isMe": false, "text": "Nos desculpe!", "time": hourAndMinute},
  {"isMe": true, "text": "Tudo bem <3", "time": hourAndMinute},
];
