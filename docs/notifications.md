# Notifications

Notifications on flutter relies on those two packages

- [Firebase messaging plugin](https://pub.dev/packages/firebase_messaging)
- [Flutter local notifications plugin](https://pub.dev/packages/flutter_local_notifications)

## Setup iOS

[Configure your iOS app to receive push notifications](https://firebase.flutter.dev/docs/messaging/apple-integration)

## Setup Android

**Congrats, you don't have to do anything!**

## How it works

1. When the app starts, we ask for the user permission to send notifications
2. If the user accepts, we register the device token in our backend
3. We initialize the firebase messaging plugin
4. We Initialize the flutter local notifications plugin
5. We listen to the firebase token refresh event. When it happens, we update the device token in our backend
6. When we receive a notification, we show it to the user. If the app is in the foreground, we show a the notification using the flutter local notification plugin. If the app is in the background, firebase will automatically show it. 

If the use log out, we unregister the device token from our backend.

## Prepare your backend

You need to create a new endpoint to register the device token in your backend.
You can see how we defined it in the `lib/notifications/api/device_api.dart` file.

## Sending a notification

// TODO show an example of a notification sent from the backend