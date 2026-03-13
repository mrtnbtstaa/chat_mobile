import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonScaffold extends StatelessWidget {

  const CommonScaffold({ 
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.drawer,
    this.endDrawer,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.resizeToAvoidBottomInset,
    this.backgroundColor,
    this.extendBody,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEnableOpenDragGesture = true,
    this.endDrawerEnableOpenDragGesture = true,
    this.extendBodyBehindAppBar = false,
    this.drawerBarrierDismissible = true,
    this.primary = true,
    this.persistentFooterButtons,
    this.persistentFooterDecoration,
    this.persistentFooterAlignment = AlignmentDirectional.centerEnd,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.scaffoldKey
   });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final Widget? drawer;
  final Widget? endDrawer;
  final Widget? bottomNavigationBar;
  final Widget? bottomSheet; 
  final Color? backgroundColor;
  final bool? resizeToAvoidBottomInset;
  final bool? extendBody;
  final DragStartBehavior drawerDragStartBehavior;
  final bool drawerEnableOpenDragGesture;
  final bool endDrawerEnableOpenDragGesture;
  final bool extendBodyBehindAppBar;
  final bool drawerBarrierDismissible;
  final bool primary;
  final List<Widget>? persistentFooterButtons;
  final BoxDecoration? persistentFooterDecoration;
  final AlignmentDirectional persistentFooterAlignment;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  Widget build(BuildContext context){

    if(appBar != null){
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: backgroundColor,
          body: body,
          appBar: appBar,
          floatingActionButton: floatingActionButton,
          drawer: drawer,
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBody: extendBody ?? false,
          drawerDragStartBehavior: drawerDragStartBehavior,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawerBarrierDismissible: drawerBarrierDismissible,
          primary: primary,
          persistentFooterButtons: persistentFooterButtons,
          persistentFooterDecoration: persistentFooterDecoration,
          persistentFooterAlignment: persistentFooterAlignment,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator
        ),
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light
        ),
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: backgroundColor,
          body: body,
          floatingActionButton: floatingActionButton,
          drawer: drawer,
          endDrawer: endDrawer,
          bottomNavigationBar: bottomNavigationBar,
          bottomSheet: bottomSheet,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBody: extendBody ?? false,
          drawerDragStartBehavior: drawerDragStartBehavior,
          drawerEnableOpenDragGesture: drawerEnableOpenDragGesture,
          endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          drawerBarrierDismissible: drawerBarrierDismissible,
          primary: primary,
          persistentFooterButtons: persistentFooterButtons,
          persistentFooterDecoration: persistentFooterDecoration,
          persistentFooterAlignment: persistentFooterAlignment,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator
        ),
      );

  }
}