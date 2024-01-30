import 'dart:async';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/components/custom_text_field.dart';
import '/constants/icons.dart';
import '/features/home/service/home_service.dart';

enum AppOverlayType { loading, add }

class AppOverlayController {
  static OverlayEntry? _overlayEntry;
  static OverlayState? _overlayState;

  static void showOverlay(BuildContext context,
      {AppOverlayType type = AppOverlayType.loading}) {
    hideOverlay();
    _overlayEntry = OverlayEntry(builder: (context) {
      switch (type) {
        case AppOverlayType.loading:
          return const _LoadingOverlayWidget();
        case AppOverlayType.add:
          return const _AddHobby();
      }
    });
    _overlayState = Overlay.of(context);
    _overlayState!.insert(_overlayEntry!);
  }

  static void hideOverlay() {
    if (_overlayEntry == null) return;
    _overlayEntry!.remove();
    _overlayEntry = null;
  }
}

class _LoadingOverlayWidget extends StatefulWidget {
  const _LoadingOverlayWidget();

  @override
  State<_LoadingOverlayWidget> createState() => _LoadingOverlayWidgetState();
}

class _LoadingOverlayWidgetState extends State<_LoadingOverlayWidget> {
  bool isVisible = false;
  Duration animationDuration = const Duration(milliseconds: 500);
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(animationDuration, (timer) {
      setState(() {
        isVisible = !isVisible;
      });
    });
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        isVisible = !isVisible;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isVisible ? 1.0 : 0.7,
      duration: animationDuration,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: AppIcons.user.toWidget(
          size: 75.w,
        ),
      ),
    );
  }
}

class _AddHobby extends StatefulWidget {
  const _AddHobby();

  @override
  State<_AddHobby> createState() => _AddHobbyState();
}

class _AddHobbyState extends State<_AddHobby> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void submit() async {
    await HomeService().add(_textEditingController.text);
    AppOverlayController.hideOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppOverlayController.hideOverlay();
      },
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 78, 74, 74),
                  ),
                  margin: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      bottom: MediaQuery.of(context).viewInsets.bottom + 50.h),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  width: double.maxFinite,
                  height: 80.h,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomTextFormField(
                          focusNode: _focusNode,
                          controller: _textEditingController,
                          hintText: "Add hobby",
                        ),
                      ),
                      Expanded(
                        child: CupertinoButton(
                            onPressed: submit,
                            child: const FittedBox(
                              child: Text(
                                "Add",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ).animate().moveY(begin: 300),
            ),
          ],
        ),
      ),
    );
  }
}
