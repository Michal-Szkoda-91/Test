# Creating your first module

## What is a module?

A module is a part of your app isolated from the rest of the app. <br>
Ex: 
- Subscription module
- Authentication module
- Notification module

All module are located in the `lib/modules` folder.<br/>
They don't know about each others. <br/>
Only the core module know about all modules and can use them.

## Create a module

1. Create a new folder in `lib/modules` with the name of your module. <br>
*Ex: `lib/modules/subscription`*<br>
2. Create `api`, `domain`, `repositories` and `ui` folders in your module folder.<br>
-> api returning entities <br>
-----> repositories returning domain <br>
---------> ui providers returning ui state <br>
([Check the architecture documentation for more info](./architecture.md))<br>
3. Create a `ui/components` folder in your module folder.<br>
Components are reusable widgets using states and providers. You don't have to necessarily create some. 
I recommend to create some if you have some widgets that you want to reuse in your module.<br>
...Or you have a really complex page and you want more readability / performance.<br>
4. Create a `ui/widget` folder in your module folder.<br>
Widgets are dumb flutter widgets that we want to use.

## Create a page

1. Create a `ui/page.dart` folder in your module folder.<br>
You can have multiple pages in your module. <br>
2. Declare your page in router (lib/router.dart) or in the bottom bar router (lib/ui/bottom_bar/bottom_bar_router.dart) if you want to add it in the bottom bar navigation ([For more info check the routing guide](./routing.md)).<br>


## Initialize a repository on startup

If you want to initialize a repository on startup you can do it in the `lib/main.dart` file.<br>

Our main builder should look like this:

```dart
return MaterialApp(
      // Initializer is a widget that allows us to run some code before the app is ready
      builder: (context, child) => Initializer(
        services: [
          // shared preferences must be loaded
          sharedPreferencesProvider,
          // notifications
          notificationsSettingsProvider,
          notificationRepository,
          // subscriptions
          subscriptionRepositoryProvider,
          // user state
          userStateNotifierProvider.notifier,
        ],
        onReady: child!,
        onLoading: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
      onGenerateRoute: routes,
    );
```

As you can see we have a list of services that we want to initialize before the app is ready.<br>
The `Initializer` widget will run all the services in the list and wait for them to be ready.<br>
When all the services are ready, the `onReady` child will be returned.<br>
If you want to customize a loading widget while the services are loading you can use the `onLoading` parameter.<br>
(Most of the time apps shows their logo at this time).