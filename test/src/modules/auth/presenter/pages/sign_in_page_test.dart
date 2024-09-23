import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:project_list_fliutter/src/modules/auth/presenter/pages/sign_in.dart';
import 'package:project_list_fliutter/src/modules/auth/presenter/stores/sign_in_store.dart';
import 'package:provider/provider.dart';

import 'sign_in_page_test.mocks.dart';

@GenerateMocks([FormStore])
void main() {
  late MockFormStore mockFormStore;

  setUp(() {
    mockFormStore = MockFormStore();
  });

  testWidgets('1. Renderiza SignInPage corretamente', (WidgetTester tester) async {

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Provider<FormStore>.value(
            value: mockFormStore,
            child: const SignInPage(),
          ),
        ),
      ),
    );

    expect(find.text('Welcome to back'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

  testWidgets('2. Exibe mensagem de erro se houver', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Provider<FormStore>.value(
            value: mockFormStore,
            child: const SignInPage(),
          ),
        ),
      ),
    );

    await tester.pump(); 
    expect(find.text('Invalid credentials'), findsOneWidget);
  });

  testWidgets('3. Faz login corretamente ao clicar no botão', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Provider<FormStore>.value(
            value: mockFormStore,
            child: const SignInPage(),
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField).first, 'user@example.com');
    await tester.enterText(find.byType(TextField).last, 'password123');
    
    final button = find.text('Sign In');
    await tester.tap(button);

    verify(mockFormStore.doLogin()).called(1);
  });

  testWidgets('4. Exibe CircularProgressIndicator enquanto carrega', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Provider<FormStore>.value(
            value: mockFormStore,
            child: const SignInPage(),
          ),
        ),
      ),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('5. Navega para a página de registro ao clicar no botão Sign Up', (WidgetTester tester) async {
    
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Provider<FormStore>.value(
            value: mockFormStore,
            child: const SignInPage(),
          ),
        ),
      ),
    );

    final signUpButton = find.text('Don\'t have an account? Sign Up');
    await tester.tap(signUpButton);

    verify(mockFormStore.linkToPage()).called(1);
  });
}