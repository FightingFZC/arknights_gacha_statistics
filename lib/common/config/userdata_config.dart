/* 
The difference between Directory.current.path and Platform.resolvedExecutable (from dart:io) 
is that Directory.current.path defaults to 
root directory of the project folder when developing, 
but on release it defaults to the folder the executable is located 
(which is the runner folder when developing). 
Also Platform.resolvedExecutable is the absolute path to the .exe 
not the directory so you have to do some small work there. Both will get you there. 
*/
import 'dart:io';

import 'package:path/path.dart';

/* here is Offical gacha API response data structure

{
  "code": 0,
  "data": {
    "list": [
      {
        "ts": 1703227241,
        "pool": "常驻标准寻访",
        "chars": [
          {
            "name": "阿消",
            "rarity": 3,
            "isNew": false
          },
          {
            "name": "清道夫",
            "rarity": 3,
            "isNew": false
          },
          {
            "name": "梓兰",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "维荻",
            "rarity": 3,
            "isNew": false
          },
          {
            "name": "米格鲁",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "史都华德",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "远山",
            "rarity": 3,
            "isNew": false
          },
          {
            "name": "炎熔",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "玫兰莎",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "安哲拉",
            "rarity": 4,
            "isNew": true
          }
        ]
      },
      {
        "ts": 1702283662,
        "pool": "游邦者",
        "chars": [
          {
            "name": "安赛尔",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "月禾",
            "rarity": 4,
            "isNew": false
          },
          {
            "name": "安赛尔",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "月见夜",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "泡普卡",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "月见夜",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "炎熔",
            "rarity": 2,
            "isNew": false
          },
          {
            "name": "砾",
            "rarity": 3,
            "isNew": false
          },
          {
            "name": "霜叶",
            "rarity": 3,
            "isNew": false
          },
          {
            "name": "白雪",
            "rarity": 3,
            "isNew": false
          }
        ]
      }
    ],
    "pagination": {
      "current": 1,
      "total": 2
    }
  },
  "msg": ""
}
 */

/* uid.json:

{
"$timestamp": {
    "c": [
      [
        "$character", // character's name
        $rarity, //0 - 5, 0 represents 1 star, the rest are the same
        $isNew   //0 or 1
      ]
    ],
    "p": "$poolName"
  }
}

sample:

"1655779346": {
    "c": [
        [
            "远山",
            3,
            0
        ]
    ],
    "p": "不协和音程"
},

the reason for using above structure is to reduce size of the gacha data file.
 */

/* structure

app/
|-- userData/
|   |-- gachaData/
|       |-- $uid.json  //each uid's gacha data
|   |-- accounts.json  // save all accounts info
*/

class UserData {
  // 根目录
  static final rootPath = Directory.current.path;

  // 用户数据位置
  static final userDataPath = join(rootPath, 'userData');

  // 账号数据位置
  static final accountInfoFilePath = join(userDataPath, 'accounts.json');

  // 账号信息请求地址
  static const accountInfoUrl =
      'https://as.hypergryph.com/u8/user/info/v1/basic';
}


