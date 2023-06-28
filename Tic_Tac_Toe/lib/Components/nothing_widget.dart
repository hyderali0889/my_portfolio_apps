import 'package:flutter/cupertino.dart';
import './nothing_element.dart';

class NothingWidget extends Widget {
  const NothingWidget({super.key});

  @override
  Element createElement() {
    return NothingElement(this);
  }
}
