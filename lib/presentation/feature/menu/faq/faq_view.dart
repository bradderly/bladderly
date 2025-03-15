// Flutter imports:
// Project imports:
import 'package:bladderly/presentation/common/extension/string_extension.dart';
import 'package:bladderly/presentation/common/widget/modal_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FaqView extends StatelessWidget {
  const FaqView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModalAppBar(
        title: 'FAQ'.tr(context),
        backButton: false,
      ),
      body: SafeArea(
        child: InAppWebView(
          gestureRecognizers: const {
            Factory(VerticalDragGestureRecognizer.new),
          },
          initialUrlRequest: URLRequest(
            url: WebUri('https://www.bladderly.com/terms-of-use'),
          ),
        ),
      ),
    );
  }
}
