import 'package:arknights_gacha_statistics/common/enum/status.dart';

class Result {
  Status status;
  String msg;
  Result(
    this.status,
    this.msg,
  );

  Result.error(this.msg) : status = Status.error;
  Result.success(this.msg) : status = Status.success;

  @override
  String toString() => 'Result(status: $status, msg: $msg)';
}
