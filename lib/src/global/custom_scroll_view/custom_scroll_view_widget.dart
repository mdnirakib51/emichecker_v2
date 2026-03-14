import 'package:flutter/material.dart';
import '../constants/colors_resources.dart';
import '../widget/global_progress_hub.dart';
import '../widget/global_text.dart';

class CustomScrollViewWidget extends StatelessWidget {
  const CustomScrollViewWidget({
    super.key,
    this.scaffoldKey,
    this.appBar,
    this.backgroundColor = ColorRes.appBackColor,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.drawer,
    this.endDrawer,
    this.bottomSheet,
    this.inAsyncCall,
    this.sliverAppBar,
    required this.slivers,
  });
  final Key? scaffoldKey;
  final PreferredSizeWidget? appBar;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomSheet;
  final bool? inAsyncCall;
  final SliverAppBarWidget? sliverAppBar;
  final List<Widget> slivers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor ?? ColorRes.appBackColor,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawer: drawer,
      endDrawer: endDrawer,
      bottomSheet: bottomSheet,
      body: ProgressHUD(
        inAsyncCall: inAsyncCall ?? false,
        child: CustomScrollView(
          slivers: [
            if (sliverAppBar != null) sliverAppBar!,
            ...slivers,
          ],
        ),
      ),
    );
  }
}

class SliverAppBarWidget extends StatelessWidget {
  const SliverAppBarWidget({
    super.key,
    this.title,
    this.titleText,
    this.titleColor,
    this.textFontSize,
    this.textFontWeight,
    this.textAlign,
    this.textFontFamily,
    this.centerTitle,
    this.isBackIc = true,
    this.pinned = true,
    this.backgroundColor = ColorRes.appColor,
    this.expandedHeight = 220,
    this.elevation = 0,
    this.leading,
    this.flexibleSpace,
    this.actions,
  });

  final Widget? title;
  final String? titleText;
  final Color? titleColor;
  final double? textFontSize;
  final FontWeight? textFontWeight;
  final String? textFontFamily;
  final TextAlign? textAlign;
  final bool? centerTitle;
  final bool? isBackIc;
  final bool? pinned;
  final Color? backgroundColor;
  final double? expandedHeight;
  final double? elevation;
  final Widget? leading;
  final Widget? flexibleSpace;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: title ?? GlobalText(
        str: titleText ?? "",
        color: titleColor ?? ColorRes.white,
        fontSize: textFontSize ?? 16,
        fontWeight: textFontWeight ?? FontWeight.w500,
        textAlign: textAlign ?? TextAlign.center,
        fontFamily: textFontFamily,
      ),
      pinned: pinned ?? true,
      expandedHeight: expandedHeight,
      backgroundColor: backgroundColor,
      elevation: elevation,
      centerTitle: centerTitle,
      leadingWidth: isBackIc == true ? 56 : 0,
      leading: leading ?? (isBackIc == true ? IconButton(
        splashRadius: 0.1,
        icon: const Icon(Icons.arrow_back, color: ColorRes.white, size: 22),
        onPressed: (){
          Navigator.pop(context);
        },
      ) : const SizedBox.shrink()),
      actions: actions,
      flexibleSpace: flexibleSpace,
    );
  }
}

sliverSizedBoxH(double? h){
  return SliverToBoxAdapter(child: SizedBox(height: h));
}

sliverSizedBoxW(double? w){
  return SliverToBoxAdapter(child: SizedBox(width: w));
}

