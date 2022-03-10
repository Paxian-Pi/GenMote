import 'package:flutter/material.dart';
import 'package:genmote/methods.dart';

class ServiceProvider extends InheritedWidget {

  final Methods methods;

  const ServiceProvider ({Key? key, required this.methods, required Widget child}) : super(key: key, child: child);

  static ServiceProvider of(BuildContext context) {
    final ServiceProvider? result = context.dependOnInheritedWidgetOfExactType<ServiceProvider>();
    assert(result != null, 'No provider found');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;
}