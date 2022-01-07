import 'package:flutter/material.dart';
import 'package:jasmine/basic/commons.dart';
import 'package:jasmine/basic/methods.dart';

const _cdnHostMap = {
  "随机": "null",
  "分流1": "\"cdn-msp.jmcdnproxy1.cc\"",
  "分流2": "\"cdn-msp.jmcdnproxy2.cc\"",
};

String _cdnHostName(String value) {
  if (value == "") {
    value = "null";
  }
  return _cdnHostMap.map((key, value) => MapEntry(value, key))[value] ?? "";
}

late String _cdnHost;

Future<void> initCdnHost() async {
  _cdnHost = await methods.loadCdnHost();
}

Widget cdnHostSetting() {
  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      return ListTile(
        onTap: () async {
          final choose = await chooseMapDialog(
            context,
            title: "API分流",
            values: _cdnHostMap,
          );
          if (choose != null) {
            await methods.saveCdnHost(choose);
            _cdnHost = choose;
            setState(() {});
          }
        },
        title: const Text("图片分流"),
        subtitle: Text(_cdnHostName(_cdnHost)),
      );
    },
  );
}
