// ignore_for_file: use_key_in_widget_constructors

import 'package:arknights_gacha_statistics/model/account.dart';
import 'package:arknights_gacha_statistics/common/enum/status.dart';
import 'package:arknights_gacha_statistics/pages/home/home_controller.dart';
import 'package:arknights_gacha_statistics/theme/global_theme_data.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  // final controller = Get.put(HomeController());
  final controller = HomeController();
  
  @override
  Widget build(BuildContext context) {
    // init param
    controller.init();

    // 上面按钮的高度
    double topButtonHeight = 40;

    var dropdownButtonKey = GlobalKey<NavigatorState>();

    var topButton = SizedBox(
      height: 100,
      child: Stack(
        children: [
          Positioned(
            top: 10,
            left: 10,
            child: Wrap(
              spacing: 20,
              children: [
                // update gacha data
                SizedBox(
                  height: topButtonHeight,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text(
                      '更新数据',
                    ),
                  ),
                ),
                SizedBox(
                  height: topButtonHeight,
                  child: Obx(() => DropdownButtonHideUnderline(
                        child: DropdownButton2<Account>(
                          key: dropdownButtonKey,
                          hint: const Text('请选择账号'),
                          value: controller.currentAccount,
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                                borderRadius: borderRadius,
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary)),
                          ),
                          dropdownStyleData: DropdownStyleData(
                            decoration: BoxDecoration(
                              borderRadius: borderRadius,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            offset: const Offset(0, -8),
                          ),
                          menuItemStyleData: MenuItemStyleData(customHeights: [
                            ...List.filled(controller.accounts.length, 40),
                            10,
                            40
                          ]),
                          onChanged: (value) {
                            controller.currentAccount = value;
                          },
                          items: [
                            ...controller.accounts
                                .map((account) => DropdownMenuItem<Account>(
                                      value: account,
                                      child: Text(account.nickName),
                                    )),
                            const DropdownMenuItem(
                                enabled: false, child: Divider()),
                            DropdownMenuItem(
                              enabled: false,
                              child: TextButton.icon(
                                onPressed: () {
                                  // 创建一个Dialog，有个输入框，输入token进去

                                  // 由于这个选项不可选，然后点击按钮后不会消失下拉框，所以得手动关闭下拉框
                                  // 下拉框其实是到了一个新路由，和dialog相似
                                  // Navigator.pop(context);
                                  Get.back();

                                  // 用于获得input框的内容
                                  TextEditingController textEditingController =
                                      TextEditingController();

                                  // TODO delete this test data
                                  textEditingController.text =
                                      '9oH+T+LsbHIxJm5VFgEOhfnY';

                                  // 打开dialog
                                  Get.defaultDialog(
                                    title: 'Token',
                                    titlePadding: const EdgeInsets.all(2),
                                    confirmTextColor: Colors.white,
                                    onConfirm: () {
                                      controller
                                          .addAccountByToken(
                                              textEditingController.text)
                                          .then((result) {
                                        switch (result.status) {
                                          case Status.success:
                                            Get.snackbar(
                                                Status.success.toString(),
                                                result.msg);
                                            break;
                                          case Status.error:
                                            Get.snackbar(
                                                Status.error.toString(),
                                                result.msg,
                                                colorText: Theme.of(context)
                                                    .colorScheme
                                                    .error);
                                          default:
                                            Get.snackbar('消息', result.msg);
                                        }
                                        controller.init();
                                      });
                                      Get.back();
                                      // snackbar principle is the same as dialog, so should do this method after Get.back()
                                    },
                                    content: TextButtonTheme(
                                      data: TextButtonThemeData(
                                        style: Theme.of(context)
                                            .textButtonTheme
                                            .style!
                                            .copyWith(
                                              minimumSize:
                                                  const MaterialStatePropertyAll(
                                                Size(100, 40),
                                              ),
                                            ),
                                      ),
                                      child: Column(
                                        children: [
                                          // login button
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () => controller
                                                      .openLoginPage(),
                                                  child: const Text('登录')),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              const Text('1. 去明日方舟官网登录'),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          // get token button
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () => controller
                                                      .openTokenPage(),
                                                  child: const Text('获取token')),
                                              const SizedBox(
                                                width: 7,
                                              ),
                                              const Text('2. 复制token')
                                            ],
                                          ),
                                          // input to write token
                                          TextField(
                                            controller: textEditingController,
                                            decoration: const InputDecoration(
                                                labelText: "token",
                                                hintText: "输入获得的token",
                                                prefixIcon:
                                                    Icon(Icons.key_rounded)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.add_rounded),
                                label: const Text('添加账号'),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Wrap(
              children: [
                SizedBox(
                  height: topButtonHeight,
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.output_rounded),
                    label: const Text('导出数据'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          topButton,
        ],
      ),
    );
  }
}
