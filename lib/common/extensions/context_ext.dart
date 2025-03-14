import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_todo_list/common/di/app_di.dart';
import 'package:test_todo_list/common/gen/localization/l10n.dart';

extension ContextExt on BuildContext {
  S get l10n => S.of(this);

  AppDi get di => read<AppDi>();
}
