// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormStore on _FormStore, Store {
  Computed<bool>? _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??=
          Computed<bool>(() => super.isValid, name: '_FormStore.isValid'))
      .value;

  late final _$isLoadingAtom =
      Atom(name: '_FormStore.isLoading', context: context);

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

  late final _$isLoggedAtom =
      Atom(name: '_FormStore.isLogged', context: context);

  @override
  bool get isLogged {
    _$isLoggedAtom.reportRead();
    return super.isLogged;
  }

  @override
  set isLogged(bool value) {
    _$isLoggedAtom.reportWrite(value, super.isLogged, () {
      super.isLogged = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_FormStore.errorMessage', context: context);

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

  late final _$navigatePageAtom =
      Atom(name: '_FormStore.navigatePage', context: context);

  @override
  bool get navigatePage {
    _$navigatePageAtom.reportRead();
    return super.navigatePage;
  }

  @override
  set navigatePage(bool value) {
    _$navigatePageAtom.reportWrite(value, super.navigatePage, () {
      super.navigatePage = value;
    });
  }

  late final _$loggedUserAtom =
      Atom(name: '_FormStore.loggedUser', context: context);

  @override
  User? get loggedUser {
    _$loggedUserAtom.reportRead();
    return super.loggedUser;
  }

  @override
  set loggedUser(User? value) {
    _$loggedUserAtom.reportWrite(value, super.loggedUser, () {
      super.loggedUser = value;
    });
  }

  late final _$doLoginAsyncAction =
      AsyncAction('_FormStore.doLogin', context: context);

  @override
  Future<void> doLogin() {
    return _$doLoginAsyncAction.run(() => super.doLogin());
  }

  late final _$_FormStoreActionController =
      ActionController(name: '_FormStore', context: context);

  @override
  void linkToPage() {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.linkToPage');
    try {
      return super.linkToPage();
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsername(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setUsername');
    try {
      return super.setUsername(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearErrorMessage() {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.clearErrorMessage');
    try {
      return super.clearErrorMessage();
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
isLogged: ${isLogged},
errorMessage: ${errorMessage},
navigatePage: ${navigatePage},
loggedUser: ${loggedUser},
isValid: ${isValid}
    ''';
  }
}
