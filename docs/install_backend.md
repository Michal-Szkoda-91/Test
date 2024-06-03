# Setup your own backend

> **Note: if you didn't already setup your backend url, please follow this [guide](./install.md).**

This architecture makes it easy to setup your own backend. <br/>
The only things you need to change are our `*_api.dart` files. <br/>
These files are directly responsible for the the api calls. <br/>

## Setup authentication API

Open the ```lib/modules/authentication/api/authentication_api.dart``` file. <br/>

Then update each method likes this:

```dart
  @override
  Future<Credentials> signup(String email, String password) async {
    try {
      final response = await _client.post(
        '/auth/signup', /// <--- Change this with your own endpoint
        data: { /// <--- Change this with your own parameters 
          'email': email,
          'password': password,
        },
      );
      return Credentials.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      _logger.e(e, stackTrace: stackTrace);
      throw ApiError.fromDioException(e);
    } catch (e) {
      _logger.e(e);
      throw ApiError(
        code: 0,
        message: '$e',
      );
    }
  }
```

Note: don't add the base url to your endpoint, it will be added automatically.

**👉 Do the same for all the other methods.**

## Setup user API

Open the ```lib/core/data/api/user_api.dart``` file. <br/>

```dart
Future<UserEntity?> get(String id) async {
    try {
        final response = await _client.get(
            '/users/$id',
        );
        if (response.data == null) {
            return null;
        }
        return UserEntity.fromJson(response.data! as Map<String, dynamic>);
    } on DioException catch (e) {
        throw ApiError.fromDioException(e);
    } catch (e, stacktrace) {
        throw ApiError(
            code: 0,
            message: '$e: $stacktrace',
        );
    }
}
```

Note: 
- don't add the base url to your endpoint, it will be added automatically.
- don't add the authentication token to your request, it will be added automatically.


## Authentication token

To customize the way we send the authentication token to your backend, open the ```lib/core/data/api/http_client.dart``` file. <br/>

By default we send the token in the `Authorization` header. <br/>
```dart
    ...
    interceptors.add(
      InterceptorsWrapper(onRequest: (options, handler) {
        if (authToken != null) {
          options.headers.putIfAbsent(
            'Authorization',
            () => 'Bearer $authToken',
          );
        }
        return handler.next(options);
      }),
    );
```

If you want to send it with a cookie or some other way, you can do it here. <br/>

### How the authentication token is stored

The authentication token is stored within the secured storage. 
We retrieve it from the secured storage in the AuthenticationRepository. <br/>

Then we keep it in memory for each of our api calls. <br/>

Then user state notifier located in (lib/core/states/user_state_notifier.dart) is responsible 
for keeping the user state up to date across the entire application. <br/>
That's why it is in the 'Core' folder. <br/>

In the ```loadState``` function we place the token in the http client. <br/>
```dart
_httpClient.authToken = credentials.token;
``` 

We could wrap this in another class for better separation of concerns. <br/>
But for now I wanted this to stay simple for everyone. 


### User state notifier

The user state notifier is responsible for keeping the user state up to date across the entire application. <br/>
The application won't go anywhere until the user state is fully loaded. <br/>

Here is the base code of the ```loadState``` function. <br/>

```dart
Future<void> _loadState() async {
    // 1. We get the credentials from the secured storage
    final credentials = await _authenticationRepository.get();
    if (credentials == null) {
      // 2. User is not connected : We set the user state to anonymous
      state = const UserState(
        user: User.anonymous(),
        subscription: Subscription.inactive(),
      );
    } else {
      // 2. User is connected : We get the user id from the credentials
      final userId = credentials.id;

      /// We set the token in the http client
      /// If you have a Oauth2 token that needs refresh maybe this could
      /// be better to create a new class responsible for this using [AuthSecuredStorage]
      /// If you use firebase you can remove this
      _httpClient.authToken = credentials.token;

      // I like to save a User automatically when the user is authenticated
      // Using firestore you can create a trigger to do this with the same document ID as the credentials
      final user = await _userRepository.get(credentials.id);
      state = state.copyWith(
        // modify this as you want to keep your user state up to date
        user: user ?? User.authenticated(id: userId, email: '', name: ''),
      );

      // Maybe save your device in UserState if you need it in your app
      try {
        final _ = await _deviceRepository.register(userId);
      } catch (err) {
        _logger.e(err);
        _logger.e('''
          ❌ Your device seems not to be registered.
          Check that you correctly setup a device registration API
          see: `lib/modules/notifications/api/device_api.dart`
        ''');
      }
      _deviceRepository.onTokenUpdate(_onUpdateToken);
    }
  }
```

As you can see we use the ```_httpClient``` to set the authentication token. <br/>
Feel free to customize this as you want. <br/>
It is a template, you can do whatever you want with it. <br/>




