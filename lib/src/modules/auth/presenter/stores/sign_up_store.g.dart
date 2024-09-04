// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SignUpStore on _SignUpStore, Store {
  Computed<bool>? _$isPasswordMatchComputed;

  @override
  bool get isPasswordMatch =>
      (_$isPasswordMatchComputed ??= Computed<bool>(() => super.isPasswordMatch,
              name: '_SignUpStore.isPasswordMatch'))
          .value;
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: '_SignUpStore.isValid'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: '_SignUpStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_SignUpStore.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isAuthAtom = Atom(name: '_SignUpStore.isAuth', context: context);

  @override
  bool get isAuth {
    _$isAuthAtom.reportRead();
    return super.isAuth;
  }

  @override
  set isAuth(bool value) {
    _$isAuthAtom.reportWrite(value, super.isAuth, () {
      super.isAuth = value;
    });
  }

  late final _$registerAsyncAction =
      AsyncAction('_SignUpStore.register', context: context);

  @override
  Future<bool> register(
      String userName, String password, String confirmPassword) {
    return _$registerAsyncAction
        .run(() => super.register(userName, password, confirmPassword));
  }

  late final _$_SignUpStoreActionController =
      ActionController(name: '_SignUpStore', context: context);

  @override
  void setUsername(String value) {
    final _$actionInfo = _$_SignUpStoreActionController.startAction(
        name: '_SignUpStore.setUsername');
    try {
      return super.setUsername(value);
    } finally {
      _$_SignUpStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_SignUpStoreActionController.startAction(
        name: '_SignUpStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_SignUpStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_SignUpStoreActionController.startAction(
        name: '_SignUpStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_SignUpStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage() {
    final _$actionInfo = _$_SignUpStoreActionController.startAction(
        name: '_SignUpStore.clearErrorMessage');
    try {
      return super.clearErrorMessage();
    } finally {
      _$_SignUpStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
errorMessage: ${errorMessage},
isAuth: ${isAuth},
isPasswordMatch: ${isPasswordMatch},
isValid: ${isValid}
    ''';
  }
}
