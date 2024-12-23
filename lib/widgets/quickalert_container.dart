import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_options.dart';
import 'package:quickalert/models/quickalert_type.dart';

import 'package:quickalert/widgets/quickalert_buttons.dart';
import 'package:quickalert/widgets/quickalert_colors.dart';

class QuickAlertContainer extends StatelessWidget {
  final QuickAlertOptions options;

  const QuickAlertContainer({
    Key? key,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final header = buildHeader(context);
    final title = buildTitle(context);
    final text = buildText(context);
    final buttons = buildButtons();
    final widget = buildWidget(context);

    final content = Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          title,
          const SizedBox(
            height: 5.0,
          ),
          text,
          widget!,
          const SizedBox(
            height: 10.0,
          ),
          buttons
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: options.backgroundColor,
        borderRadius: BorderRadius.circular(options.borderRadius!),
      ),
      clipBehavior: Clip.antiAlias,
      width: options.width ?? MediaQuery.of(context).size.shortestSide,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [header, content],
      ),
    );
  }

  Widget buildHeader(context) {
    IconData? icon = Icons.task_alt_rounded;
    switch (options.type) {
      case QuickAlertType.success:
        icon = Icons.task_alt_rounded;
        break;
      case QuickAlertType.error:
        icon = Icons.warning_rounded;
        break;
      case QuickAlertType.warning:
        icon = Icons.error;
        break;
      case QuickAlertType.confirm:
        icon = Icons.help;
        break;
      case QuickAlertType.info:
        icon = Icons.info;
        break;
      case QuickAlertType.loading:
        icon = Icons.loop_rounded;
        break;
      default:
        icon = Icons.info;
        break;
    }

    Color? color = Colors.green;
    switch (options.type) {
      case QuickAlertType.success:
        color = Colors.green;
        break;
      case QuickAlertType.error:
        color = Colors.red;
        break;
      case QuickAlertType.warning:
        color = Colors.yellow;
        break;
      case QuickAlertType.confirm:
        color = Colors.blue;
        break;
      case QuickAlertType.info:
        color = Colors.blue;
        break;
      case QuickAlertType.loading:
        color = Colors.white;
        break;
      default:
        color = Colors.white;
        break;
    }

    if (options.customIcon != null) {
      icon = options.customIcon;
    }
    return Container(
      width: double.infinity,
      height: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: options.headerBackgroundColor,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: options.headerBackgroundColor,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary,
              ),
              padding: const EdgeInsets.all(11.0),
              child: Icon(
                icon,
                size: 80,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTitle(context) {
    final title = options.title ?? whatTitle();
    return Visibility(
      visible: title != null,
      child: Text(
        '$title',
        textAlign: options.titleAlignment ?? TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: options.titleColor,
                ) ??
            TextStyle(
              color: options.titleColor,
            ),
      ),
    );
  }

  Widget buildText(context) {
    if (options.text == null && options.type != QuickAlertType.loading) {
      return Container();
    } else {
      String? text = '';
      if (options.type == QuickAlertType.loading) {
        text = options.text ?? 'Loading';
      } else {
        text = options.text;
      }
      return Text(
        text ?? '',
        textAlign: options.textAlignment ?? TextAlign.center,
        style: TextStyle(
          color: options.textColor,
        ),
      );
    }
  }

  Widget? buildWidget(context) {
    if (options.widget == null && options.type != QuickAlertType.custom) {
      return Container();
    } else {
      Widget widget = Container();
      if (options.type == QuickAlertType.custom) {
        widget = options.widget ?? widget;
      }
      return options.widget;
    }
  }

  Widget buildButtons() {
    return QuickAlertButtons(
      options: options,
    );
  }

  String? whatTitle() {
    switch (options.type) {
      case QuickAlertType.success:
        return 'Success';
      case QuickAlertType.error:
        return 'Error';
      case QuickAlertType.warning:
        return 'Warning';
      case QuickAlertType.confirm:
        return 'Are You Sure?';
      case QuickAlertType.info:
        return 'Info';
      case QuickAlertType.custom:
        return null;
      case QuickAlertType.loading:
        return null;
      default:
        return null;
    }
  }
}
