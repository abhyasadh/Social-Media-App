import 'package:Yaallo/connectivity_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:flutter_svg/svg.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final connectivity = ref.watch(connectivityProvider);

    return MaterialApp(
      title: 'Yaallo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: connectivity == ConnectivityStatus.isConnected ? const WebApp() : const NoInternetWidget(),
    );
  }
}

class WebApp extends ConsumerStatefulWidget {
  const WebApp({super.key});

  @override
  ConsumerState<WebApp> createState() => _WebAppState();
}

class _WebAppState extends ConsumerState<WebApp> {
  late final WebViewController controller;
  late final PlatformWebViewControllerCreationParams params;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );

      controller = WebViewController.fromPlatformCreationParams(params);
    } else {
      params = const PlatformWebViewControllerCreationParams();
      controller = WebViewController();
    }

    if (controller.platform is AndroidWebViewController) {
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    controller.setBackgroundColor(const Color(0xffffffff));
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {
          setState(() {
            isLoading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            isLoading = false;
          });
        },
        onHttpError: (HttpResponseError error) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );

    controller.loadRequest(Uri.parse('https://www.yaallo.com'));
  }

  Future<bool> _onWillPop() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          body: WebViewWidget(
            controller: controller,
          ),
        ),
      ),
    );
  }
}

class NoInternetWidget extends StatelessWidget {
  final double bottomPadding;

  const NoInternetWidget({super.key, this.bottomPadding = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SvgPicture.asset(
              'assets/images/no_internet.svg',
              colorFilter: const ColorFilter.mode(
                Color(0xffB0E3F5),
                BlendMode.srcIn,
              ),
              width: MediaQuery.of(context).size.width / 1.5,
            ),
          ),
          const SizedBox(height: 12,),
          const Text('No Connection!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
          const SizedBox(height: 6,),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Please check your internet connection and try again...'),
          ),
          SizedBox(height: bottomPadding,)
        ],
      ),
    );
  }
}
