import 'package:flutter/widgets.dart';
import 'package:lang_app/core/auth_service.dart';
import 'package:lang_app/core/database.dart';

class InheritedDataProvider extends InheritedWidget {
  final AuthService authService;

  final DatabaseService databaseService;

  const InheritedDataProvider({
    required Widget child,
    required this.authService,
    required this.databaseService,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) =>
      authService != oldWidget.authService;

  static InheritedDataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>();
  }
}
