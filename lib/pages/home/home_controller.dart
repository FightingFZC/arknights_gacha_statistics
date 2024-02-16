import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:arknights_gacha_statistics/common/config/userdata_config.dart';
import 'package:arknights_gacha_statistics/common/enum/status.dart';
import 'package:arknights_gacha_statistics/model/account.dart';
import 'package:arknights_gacha_statistics/model/accounts_json.dart';
import 'package:arknights_gacha_statistics/model/result.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeController {
  final _currentAccount = Rx<Account?>(null);
  final _accounts = <Account>[].obs;

  Account? get currentAccount => _currentAccount.value;

  set currentAccount(Account? value) => _currentAccount.value = value;

  List<Account> get accounts => _accounts;

  set accounts(List<Account> value) => _accounts.value = value;

  HomeController() {
    log('create a HomeController');
  }

  init() {
    loadAccountsInfo();
    loadGachaData(currentAccount);
  }

  // load exist accounts info
  Result loadAccountsInfo() {
    var result = Result.error('');

    // 1. get file and read it
    File file = File(UserData.accountInfoFilePath);
    if (!file.existsSync()) {
      result.msg = '未添加账号';
      return result;
    }

    // 2. convert file content to json and get it's param

    AccountsJson accountsInfo;
    try {
      accountsInfo = AccountsJson.fromJson(file.readAsStringSync());
    } on Exception {
      log('json文件错误');
      accountsInfo = AccountsJson.empty();
    }

    // 3. set Controller's params to got value

    currentAccount = accountsInfo.currentAccount;
    accounts = accountsInfo.accounts ?? [];

    result.status = Status.success;
    result.msg = '加载账号信息成功';
    return result;
  }
  
  Future<Result> addAccountByToken(String token) async {
    token = token.trim();
    Result result = Result.error('');
    GetConnect http = GetConnect();
    Response resp = await http.post<Map>(UserData.accountInfoUrl, {
      'appId': 1,
      'channelMasterId': 1,
      'channelToken': {'token': token}
    });

    if (resp.statusCode == null) {
      result.msg = '请求失败！';
      log('请求失败！: ${resp.statusText}');
      return result;
    } else if (resp.statusCode! > 500) {
      result.msg = '服务器出问题啦';
      log('请求失败！: ${resp.statusText}');
      return result;
    }

    var data = resp.body;

    // if token is wrong, returnd status is '3'
    if (data['status'] == 3) {
      var msg = 'token失效或错误';
      result.msg = msg;
      log(msg);

      return result;
    }

    // 获取信息。
    var nickName = data['data']['nickName'];

    var uid = data['data']['uid'];

    var account = Account(uid, nickName, token);

    // save account at local
    var file = File(UserData.accountInfoFilePath);

    // if not exist, write in a template
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync(jsonEncode(AccountsJson.empty()));
    }

    // read file as map and add this account
    AccountsJson accountsInfo;
    try {
      accountsInfo = AccountsJson.fromJson(file.readAsStringSync());
    } on Exception {
      log('json文件错误');
      accountsInfo = AccountsJson.empty();
    }

    accountsInfo.currentAccount = account;

    List<Account> accounts = accountsInfo.accounts ?? [];
    if (accounts.contains(account)) {
      // already existed
      var msg = '账号已存在';
      log(msg);
      return Result(Status.error, msg);
    } else {
      accounts.add(account);
      accountsInfo.accounts = accounts;
    }

    // Object to json should write toJson(), and return type prefer Map,
    // if toJson() return a String, jsonEncode(object) returned value may not be as expected
    // For example: object is jsonEncode(Account('a', 'b', 'c')) returns {\'uid\': \'a\' ...}
    // [\] is not expected

    // rewrite this file
    file.writeAsStringSync(jsonEncode(accountsInfo));

    result.status = Status.success;
    result.msg = '添加账号成功';
    return result;
  }

  // load gacha data
  Future<Result> loadGachaData(Account? account) async {
    var result = Result.error('');

    if (account == null) {
      result.msg = '无账号';
      return result;
    }
    // 1. get latest data from official api
    // TODO suspend  development
    // 2. load local data
    // 3. merge these data(should remove duplicate data)
    // 4. set it to Controller's param


    result.msg = '成功加载抽卡数据';
    return result;
  }

  openLoginPage() {
    launchUrlString('https://ak.hypergryph.com/');
  }

  openTokenPage() {
    launchUrlString('https://web-api.hypergryph.com/account/info/hg');
  }
}
