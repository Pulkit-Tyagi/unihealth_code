import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/const/color_const.dart';
import 'package:riverpod_example/view_model/cid_screen_vm.dart';

class CidScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<CidScreen> createState() => _CidScreenState();
}

class _CidScreenState extends ConsumerState<CidScreen> {
  late CidScreenVM _vm;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vm = CidScreenVM(ref);
    Future.delayed(Duration.zero, () => _vm.fetchCidData());
  }

  var clr = AppConstColor().appThemeColor;
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: getBody(),
    ));
  }

  Widget getBody() {
    var isLoading = ref.watch(_vm.isLoading);
    if (isLoading == true) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        child: Consumer(
          builder: (context, ref, child) {
            final data = ref.watch(_vm.data);
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      color: Colors.white10,
                      height: 40,
                      child: Center(
                          child: Text(
                            '${data[index].cidname}',
                            style: const TextStyle(color: Colors.black),
                          )),
                    ),
                  ),
                );
              },
              itemCount: data!.length,
            );
          },
        ),
      );
    }
  }
}
