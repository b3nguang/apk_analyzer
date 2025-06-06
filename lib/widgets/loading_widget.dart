import 'package:flutter/material.dart';

class _CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // 弹窗整体的样式
      color: Colors.black54,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
            const SizedBox(height: 16.0),
            Text(
              '正在分析',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}


class MyLoading {
  static OverlayEntry? _overlayEntry;
 
  static void showLoading(BuildContext context) {
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) => _CustomLoading(),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }
 
  static void hideLoading() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}
