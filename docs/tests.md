# Testing guide

Firstly I have to say that this whole guide is based on our own experience and our own way of doing things.
It's what we found to be the best way to test our apps. 

## Why testing is important

It helps you to find bugs and regressions. It also helps you to write better code and to have a better architecture.
Don't try to test everything. Test scenarios that are important for your app.

## ApparenceKit tests 

### Write a unit tests 

First of all. A unit test is NOT a test for a single function. It's an isolated test that tests a single unit of code.
Your tests should not depend on any external dependencies. (API, database, etc...)<br>
That's why most of the time developpers use mocks.<br>
But in our case, we don't use mocks. We use a fake implementation of our dependencies.<br>
For example, if we want to test a function that uses the `SharedPreferences` we will use a fake implementation of the `SharedPreferences`.<br>

**Why?**<br>
- Because we don't want our tests to reflect our implementation. We want to test our business logic and not our implementation.
- A test shouldn't be updated because of a change in the implementation. It should be updated only if the business logic changes.
- It's easier to write tests with a fake implementation than with mocks. (reading all mocking declaration in tests are a pain)

**Write a unit test**<br>

I like to split tests declaration in two parts:
- [current context] -> [expected result]


```dart
void main() {

    test('user is connected -> should throw an error', () {
        //... write your code
    });
}
```

You can also use the `group` function to group your tests by context.

```dart
void main() {

    group('user is connected', () {
        test('should throw an error', () {
            //... write your code
        });
    });
}
```

Do it as you prefer. But keep in mind that your tests should be easy to read and to understand.

### Write a widget test

A widget test is a test using the flutter testing framework. <br>
So you can test your app close to the reality.

To help you to write widget tests we created a `WidgetTester` extension named `AppWidgetTester`. <br>
You can find it in `test/test-utils.dart`.<br>
This extension contains a function to create a widget with 
- a `MaterialApp` and a `Navigator`
- running the Initializer like the our main.dart
- push a fake implementation of all external API (so each time you create one, add it to this function)
- allow you to overide each dependencies with your own implementation
- push a fake UserState (so you can test your app with a connected user or not)


```dart
  testWidgets(
    'user is not logged in => should not show any premium selection ',
    (tester) async {
      await tester.pumpPage(
        userState: const UserState(
          subscription: Subscription.inactive(),
          user: User.anonymous(),
        ),
        home: const PremiumPage(), // the page you want to test
      );

      expect(find.byType(PremiumPageContent), findsNothing);
      expect(find.byType(ActivePremiumContent), findsNothing);
    },
  );
```

Like this your tests will be more realistic and you will be able to test your app like a user.

Also these tests are easy to write, to read and to maintain.👌

-------

**🔥 Tips**:
- try to write your test before your code. It will help you to think about your code and to write better code.
- don't run your code on any device until are your tests are green. Adjusting UI details takes a lot of time. I tend to prefer making it work then making it great. (Step by step)
- refactor your code after your tests are green. It's easier to refactor when you have tests.
If you don't know how to refactor your code, then start reading M.Fowler's book: [Refactoring: Improving the Design of Existing Code](https://martinfowler.com/books/refactoring.html). Every developper that has been hired at Apparence.io has read this book. It's a must read.
- Every time you encounter a bug. Try to write a test that reproduce the bug. Then fix the bug. And finally, add the test to your test suite. This way you will be sure that this bug will never come back.


## Device test extension

We created a `DeviceTestExtension` to help you with device sizes

Use this extension to set the screen size of the device in tests
This allows to test the UI on different devices and check for some overflow

First import the extension file located in `test/device_test_utils.dart`

Example:

```dart
testWidgets('should show the page', (tester) async {
    await tester.setScreenSize(iphone8Plus);
    await tester.pumpWidget(MyApp());
    expect(find.byType(MyPage), findsOneWidget);
});
```

Now there is something even better. 
We can run all pre defined device tests withing a single test using the variant parameter. 

Like this
    
```dart
testWidgets('should show the page', (tester) async {
    await tester.setScreenSize(deviceVariants.currentValue!);
    await tester.pumpWidget(MyApp());
    expect(find.byType(MyPage), findsOneWidget);
}, variant: deviceVariants);
```

You can still use integration test for better results but this is a good start and can be simpler to use.