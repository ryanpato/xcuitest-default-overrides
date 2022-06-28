# Flamingo 🦩

A simple app that has nothing to do with flamingos, created to investigate and implement a  workaround for funky behaviour that can happen when using launch arguments to override user default properties from ui-tests.

Overriding userdefault values can be useful in speeding up ui-tests by configuring the state in advance. For e.g. 'should show onboarding' can be set to `false`, and the app can be pre-authorised for e.g. with a 'token'.

## The problem :thinking:

**Steps:**
1. Launch App
2. Defaults are wiped per `launchArgument` flag e.g. "uitesting"
3. Default userdefaults property e.g. "token" is overriden via `launchArgument`
4. App appears logged in
5. Tap signout in XCUITest
6. Observe view state does not change in app under test :ghost:

This is because the argument domain does not persist the value, it's read-only. So when the token is "overridden" to a value, it is actually still an empty string after the reset in persistence store (step 2), then when we tap the signout button (step 5), the value is set from empty string to empty string, meaning no change occurs and the view won't update.

## Launch Environment :rocket:

Rather than use the argument domain:
- Encode the user default configurations in the `XCUITest` target
- Pass them into the app via `launchEnvironment`
- Decode and set values in persistence store in app

I updated locally swift-user-defaults to do this similar to the `launchArgumentsOverride` method to achieve this.

## Notes :notebook:

- There are two ui-tests for signing-out to demonstrate the issue. One uses launch arguments, the other launch environment. They fail and pass respectively.
- The app uses a separate defaults instance for testing, so it shouldn't be an issue to store into persistence from a test.
