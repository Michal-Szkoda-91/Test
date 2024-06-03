# Handling errors and monitoring

Handling errors is something important. 

## Fail fast or fail safe. 
I would suggest you to define what kind of error you are facing. 
There is nothing more frustrating for an user than a red error screen.<br> 
When you detect an anormal error show a kind error message that you saved this error and you suggest him to retry. 
(If error persist retry later). <br/>
<br/>
For example an authentication Api error is critical. You will catch this error and explain this to your user. 
<br/>
<br/>
Fail fast means that you want to throw as soon as you detect something anormal. 
As dart has an awesome null safety check you will have less work to do this. 

## Base API error

We recommand your API to throw using a strict pattern to help your app handling errors. 
<br>
check ```lib/core/data/api/base_api_exceptions.dart```

Customize your errors as you want
```dart
class ApiError implements Exception {
  final String? code;
  final String? message;

  ApiError({
    this.code,
    this.message,
  });

  factory ApiError.fromDioException(DioException e) {
    return ApiError(
      // ignore: avoid_dynamic_calls
      code: e.response?.data['code'] as String?,
      // ignore: avoid_dynamic_calls
      message: e.response?.data['message'] as String?,
    );
  }
}
```

## Show an error

ShowErrorToast uses the package ```another_flushbar```.
This will help your showing an animated temporary message. 
It will be shown on top of application. (Because for example you want to show errors even if keyboard is opened).

```dart
ref
    .read(signupStateProvider.notifier)
    .signup()
    .then((value) => Navigator.of(context)
            .pushReplacementNamed('/'),
        )
        .catchError((err) {
                showErrorToast(
                    context: context,
                    title: 'Error',
                    text: (err as SignupException).message ?? '',
                );
                return err;
            },
            test: (err) => err is SignupException)
        .catchError((err) {
                showErrorToast(
                    context: context,
                    title: 'Error',
                    text: 'Fill a valid email and password',
                );
                return err;
            },
    );
```

## Crash and errors reporting tool

I personnaly recommend Sentry over any other. 

It's really well made with flutter and gives you a lot if informations to find the root cause of any bug. 
- [Check Sentry flutter package here](https://pub.dev/packages/sentry_flutter)

Using our CLI you can easily add sentry to your project.
By default we ask you on setup but you can add it later. 

```bash
dart pub global run apparence_cli sentry .
```
