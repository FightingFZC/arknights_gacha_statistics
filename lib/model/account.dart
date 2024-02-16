import 'dart:convert';

class Account {
  String uid;
  String nickName;
  String token;
  Account(
    this.uid,
    this.nickName,
    this.token,
  );

  Account copyWith({
    String? uid,
    String? nickName,
    String? token,
  }) {
    return Account(
      uid ?? this.uid,
      nickName ?? this.nickName,
      token ?? this.token,
    );
  }


  @override
  String toString() => 'Account(uid: $uid, nickName: $nickName, token: $token)';

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;
  
    return 
      other.uid == uid &&
      other.nickName == nickName &&
      other.token == token;
  }

  @override
  int get hashCode => uid.hashCode ^ nickName.hashCode ^ token.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'nickName': nickName,
      'token': token,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      map['uid'] as String,
      map['nickName'] as String,
      map['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory Account.fromJson(String source) => Account.fromMap(json.decode(source));
}
