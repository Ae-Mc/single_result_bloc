<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# SingleResultBloc

This package adds additional `SingleResult` stream to standard `State` stream of
`Bloc`. This stream can be listened via `SingleResultBlocBuilder`'s
`onSingleResult` parameter. This allows to send one-time events like showing
toasts or moving to another page after successful login for example.

## Usage

```dart
// auth_bloc.dart
class AuthBloc
    extends SingleResultBloc<AuthEvent, AuthState, AuthSingleResult> {
    AuthBloc() : super(AuthState.unauthorized()) {
        on<AuthEventAuthorize>((event, emit) {
            // somehow login

            addSingleResult(const AuthSingleResult.loginSuccess());
        });
    }
}

// auth_page.dart
class AuthPage extends StatelessWidget {
    Widget build(BuildContext context) {
        return SingleResultBlocBuilder<AuthBloc, AuthState, AuthSingleResult> {
            onSingleResult: (context, singleResult) {
                if (singleResult is AuthSingleResultLoginSuccess) {
                    Navigator.of(context).pushReplacementNamed('login/success');
                }
            }
            builder: (context, state) => LoginWidget(state),
        }
    }
}
```
