// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:arknights_gacha_statistics/model/account.dart';

/* this class is the accounts.json file's model class */

/* accounts.json:
{
  "currentAccount": {
      "uid": "$uid",
      "nickName": "$nickName",
      "token": "$token"
  },  
  "accounts": [
    {
      "uid": "$uid",
      "nickName": "$nickName",
      "token": "$token"
    }
  ]
}
 */

class AccountsJson {
  Account? currentAccount;
  List<Account>? accounts;
  AccountsJson(
    this.currentAccount,
    this.accounts,
  );

  AccountsJson.empty();

  AccountsJson copyWith({
    Account? currentAccount,
    List<Account>? accounts,
  }) {
    return AccountsJson(
      currentAccount ?? this.currentAccount,
      accounts ?? this.accounts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentAccount': currentAccount?.toMap(),
      'accounts': accounts?.map((x) => x.toMap()).toList(),
    };
  }

  factory AccountsJson.fromMap(Map<String, dynamic> map) {
    return AccountsJson(
      map['currentAccount'] != null
          ? Account.fromMap(map['currentAccount'] as Map<String, dynamic>)
          : null,
      map['accounts'] != null
          ? List<Account>.from(
              (map['accounts'] as List).map<Account?>(
                (x) => Account.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory AccountsJson.fromJson(String source) =>
      AccountsJson.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'AccountsJson(currentAccount: $currentAccount, accounts: $accounts)';

  @override
  bool operator ==(covariant AccountsJson other) {
    if (identical(this, other)) return true;

    return other.currentAccount == currentAccount &&
        listEquals(other.accounts, accounts);
  }

  @override
  int get hashCode => currentAccount.hashCode ^ accounts.hashCode;
}
