import 'package:flutter/cupertino.dart';

class NothingElement extends Element {
  NothingElement(super.widget);

  @override
  bool get debugDoingBuild => false;

  @override
  void performRebuild() {
    super.performRebuild();
  }
}
