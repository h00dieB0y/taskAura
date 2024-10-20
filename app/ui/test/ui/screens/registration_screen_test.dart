// Import Statements
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui/blocs/registration/registration.bloc.dart';
import 'package:ui/blocs/registration/registration.event.dart';
import 'package:ui/blocs/registration/registration.state.dart';
import 'package:ui/ui/screens/registration.screen.dart';
import 'package:ui/ui/widgets/custom_text_field.widget.dart';

// Mock Classes

// MockRegistrationBloc using mockito
class MockRegistrationBloc
    extends MockBloc<RegistrationEvent, RegistrationState>
    implements RegistrationBloc {}

// Helper Function to Create the Widget Under Test
Widget createWidgetUnderTest(MockRegistrationBloc mockBloc) {
  return MaterialApp(
    home: BlocProvider<RegistrationBloc>(
      create: (_) => mockBloc,
      child: const RegistrationScreen(),
    ),
  );
}

void main() {
  // Define variables for mockBloc and other reusable components
  late MockRegistrationBloc mockBloc;

  // Setup before each test
  setUp(() {
    mockBloc = MockRegistrationBloc();
  });

  // Teardown after each test
  tearDown(() {
    mockBloc.close();
  });

  // Test Categories

  // A. UI Rendering Tests
  group('RegistrationScreen UI Rendering', () {
    testWidgets('Displays registration header correctly',
        (WidgetTester tester) async {
      // Arrange
      whenListen(
        mockBloc,
        Stream.fromIterable([RegistrationInitial()]),
        initialState: RegistrationInitial(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(mockBloc));

      // Assert
      // Use a widget predicate to find the header 'Sign up' based on font size
      final headerFinder = find.byWidgetPredicate((widget) {
        if (widget is Text) {
          return widget.data == 'Sign up' && widget.style?.fontSize == 24;
        }
        return false;
      });

      expect(headerFinder, findsOneWidget);
      expect(find.text('Create an account to get started'), findsOneWidget);
    });

    testWidgets('Displays email, password, and confirm password fields',
        (WidgetTester tester) async {
      // Arrange
      whenListen(
        mockBloc,
        Stream.fromIterable([RegistrationInitial()]),
        initialState: RegistrationInitial(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(mockBloc));

      // Assert
      expect(find.byType(CustomTextFieldWidget), findsNWidgets(3));
      expect(
          find.widgetWithText(CustomTextFieldWidget, 'Email'), findsOneWidget);
      expect(find.widgetWithText(CustomTextFieldWidget, 'Password'),
          findsOneWidget);
      expect(find.widgetWithText(CustomTextFieldWidget, 'Confirm Password'),
          findsOneWidget);
    });

    testWidgets('Password fields are obscured by default',
        (WidgetTester tester) async {
      // Arrange
      whenListen(
        mockBloc,
        Stream.fromIterable([RegistrationInitial()]),
        initialState: RegistrationInitial(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(mockBloc));

      // Assert
      final passwordField = tester.widget<CustomTextFieldWidget>(
          find.widgetWithText(CustomTextFieldWidget, 'Password'));
      final confirmPasswordField = tester.widget<CustomTextFieldWidget>(
          find.widgetWithText(CustomTextFieldWidget, 'Confirm Password'));

      expect(passwordField.obscureText, isTrue);
      expect(confirmPasswordField.obscureText, isTrue);
    });

    testWidgets('Displays enabled Sign up button', (WidgetTester tester) async {
      // Arrange
      whenListen(
        mockBloc,
        Stream.fromIterable([RegistrationInitial()]),
        initialState: RegistrationInitial(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(mockBloc));

      // Assert
      final signUpButton = find.widgetWithText(ElevatedButton, 'Sign up');
      expect(signUpButton, findsOneWidget);

      final ElevatedButton buttonWidget =
          tester.widget<ElevatedButton>(signUpButton);
      expect(buttonWidget.enabled, isTrue);
    });
  });

  // C. Interaction Tests
  group('RegistrationScreen User Interactions', () {
    testWidgets('Toggles password visibility', (WidgetTester tester) async {
      // Arrange
      whenListen(
        mockBloc,
        Stream.fromIterable([RegistrationInitial()]),
        initialState: RegistrationInitial(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(mockBloc));

      final passwordField =
          find.widgetWithText(CustomTextFieldWidget, 'Password');
      final visibilityIconOff = find.descendant(
          of: passwordField, matching: find.byIcon(Icons.visibility_off));

      expect(visibilityIconOff, findsOneWidget);

      // Tap the visibility icon to toggle
      await tester.tap(visibilityIconOff);
      await tester.pump();

      // Assert
      final visibilityIconOn = find.descendant(
          of: passwordField, matching: find.byIcon(Icons.visibility));
      expect(visibilityIconOn, findsOneWidget);
    });

    testWidgets('Toggles confirm password visibility',
        (WidgetTester tester) async {
      // Arrange
      whenListen(
        mockBloc,
        Stream.fromIterable([RegistrationInitial()]),
        initialState: RegistrationInitial(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(mockBloc));

      final confirmPasswordField =
          find.widgetWithText(CustomTextFieldWidget, 'Confirm Password');
      final visibilityIconOff = find.descendant(
          of: confirmPasswordField,
          matching: find.byIcon(Icons.visibility_off));

      expect(visibilityIconOff, findsOneWidget);

      // Tap the visibility icon to toggle
      await tester.tap(visibilityIconOff);
      await tester.pump();

      // Assert
      final visibilityIconOn = find.descendant(
          of: confirmPasswordField, matching: find.byIcon(Icons.visibility));
      expect(visibilityIconOn, findsOneWidget);
    });

    testWidgets('Updates text fields on input', (WidgetTester tester) async {
      // Arrange
      whenListen(
        mockBloc,
        Stream.fromIterable([RegistrationInitial()]),
        initialState: RegistrationInitial(),
      );

      // Act
      await tester.pumpWidget(createWidgetUnderTest(mockBloc));

      await tester.enterText(
          find.widgetWithText(CustomTextFieldWidget, 'Email'),
          'test@example.com');
      await tester.enterText(
          find.widgetWithText(CustomTextFieldWidget, 'Password'),
          'TestPass123');
      await tester.enterText(
          find.widgetWithText(CustomTextFieldWidget, 'Confirm Password'),
          'TestPass123');

      // Assert
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('TestPass123'), findsNWidgets(2));
    });
  });
}
