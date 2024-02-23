import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;
  final int color;

  const WebViewScreen(
      {Key? key, required this.url, required this.title, this.color = 0xff086EB2}) : super(key: key);

  @override
  _WebViewScreenState createState() =>
      _WebViewScreenState(url: url, title: title, color: color);
}

class _WebViewScreenState extends State<WebViewScreen> {
  String url;
  final String title;
  final int color;

  _WebViewScreenState(
      {required this.url, required this.title, required this.color});

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool isLoading = true;

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    super.initState();
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: IconButton(
            splashRadius: 24,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 20),
          ),
        ),
        backgroundColor: Color(color),
        // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
      ),
      // We're using a Builder here so we have a context that is below the Scaffold
      // to allow calling Scaffold.of(context) so we can show a snackbar.
      body: Builder(builder: (BuildContext context) {
        return Stack(
          children: [
            WebView(
              debuggingEnabled: true,
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                if (progress == 100) {
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              javascriptChannels: <JavascriptChannel>{
                _toasterJavascriptChannel(context),
              },
              navigationDelegate: (NavigationRequest request) async {
                if (request.url.contains('https://helpertapp.page.link/Fu3N')) {
                  Navigator.pop(context);
                  return NavigationDecision.prevent;
                }
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {},
              onPageFinished: (String url) {},
              gestureNavigationEnabled: true,
              backgroundColor: const Color(0x00000000),
            ),
            if (isLoading) Center(child: CircularProgressIndicator())
          ],
        );
      }),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }

  // _launchURL(String url) async {
  //   if (await canLaunchUrl(Uri.parse(uri))) {
  //     await launchUrl(Uri.parse(url));
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}
