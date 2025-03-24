import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:notifly_flutter/notifly_flutter.dart';

@module
abstract class EventAnalyzerModule {
  @lazySingleton
  EventAnalyzer get eventAnalyzer => _EventAnalyzer(firebaseAnalytics: FirebaseAnalytics.instance);

  @lazySingleton
  RouteObserver get routeObserver => FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance);
}

abstract class EventAnalyzer {
  Future<void> initializeUser({
    required String userId,
    required Map<String, Object> userProperties,
  });

  Future<void> clearUser();

  Future<void> setUserProperties({
    required Map<String, Object> userProperties,
  });

  Future<void> logEvent({
    required String eventName,
    Map<String, Object>? eventParams,
  });
}

class _EventAnalyzer implements EventAnalyzer {
  const _EventAnalyzer({
    required FirebaseAnalytics firebaseAnalytics,
  }) : _firebaseAnalytics = firebaseAnalytics;

  final FirebaseAnalytics _firebaseAnalytics;

  @override
  Future<void> initializeUser({
    required String userId,
    required Map<String, Object> userProperties,
  }) {
    return Future.wait([
      _firebaseAnalytics.setUserId(id: userId).then(
            (_) => Future.wait(
              userProperties.entries.map(
                (e) => _firebaseAnalytics.setUserProperty(name: e.key, value: e.value.toString()),
              ),
            ),
          ),
      NotiflyPlugin.setUserId(userId).then((_) => NotiflyPlugin.setUserProperties(userProperties)),
    ]);
  }

  @override
  Future<void> clearUser() {
    return Future.wait([
      _firebaseAnalytics.setUserId(),
      NotiflyPlugin.setUserId(null),
    ]);
  }

  @override
  Future<void> setUserProperties({
    required Map<String, Object> userProperties,
  }) {
    return Future.wait([
      Future.wait(
        userProperties.entries.map(
          (e) => _firebaseAnalytics.setUserProperty(name: e.key, value: e.value.toString()),
        ),
      ),
      NotiflyPlugin.setUserProperties(userProperties),
    ]);
  }

  @override
  Future<void> logEvent({
    required String eventName,
    Map<String, Object>? eventParams,
  }) {
    return Future.wait([
      _firebaseAnalytics.logEvent(name: eventName, parameters: eventParams),
      NotiflyPlugin.trackEvent(
        eventName: eventName,
        eventParams: eventParams,
      ),
    ]);
  }
}
