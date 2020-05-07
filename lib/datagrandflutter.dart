import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Datagrandflutter {
  factory Datagrandflutter() => _instance;

  Datagrandflutter.private(MethodChannel platformChannel)
      : _channel = platformChannel;

  final MethodChannel _channel;

  static final Datagrandflutter _instance =
      Datagrandflutter.private(const MethodChannel('datagrandflutter'));

  Future<void> init({@required String appId}) async {
    await _channel.invokeMethod('init', <String, dynamic>{'appId': appId});
  }

  Future<void> logEvent({@required String name}) async {
    await _channel.invokeMethod('logEvent', <String, dynamic>{'name': name});
  }
}
