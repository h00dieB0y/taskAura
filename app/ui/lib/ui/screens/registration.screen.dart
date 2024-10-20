import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/blocs/registration/registration.bloc.dart';
import 'package:ui/blocs/registration/registration.event.dart';
import 'package:ui/blocs/registration/registration.state.dart';
import 'package:ui/ui/widgets/custom_text_field.widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordObscured = !_isPasswordObscured;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordObscured = !_isConfirmPasswordObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegistrationBloc(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.surface,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _registrationHeader(context),
                  const SizedBox(height: 32),
                  _registrationForm(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _registrationHeader(BuildContext context) => Column(
        children: [
          const SizedBox(height: 60),
          Text(
            'Sign up',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Create an account to get started',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );

  Widget _registrationForm() {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        state.when(
          onInitial: () {},
          onLoading: () {
            // Show loading indicator
          },
          onSuccess: () {
            _showSnackBar(context, 'Registration successful', Colors.green);
          },
          onFailure: (message) {
            _showSnackBar(context, message, Colors.red);
          },
        );
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextFieldWidget(
              controller: _emailController,
              labelText: 'Email',
              hintText: 'e.g., john.doe@example.com',
              prefixIcon: Icons.email,
              keyboardType: TextInputType.emailAddress,
              // Example validation can be added here if necessary
            ),
            const SizedBox(height: 16),
            CustomTextFieldWidget(
              controller: _passwordController,
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: Icons.lock,
              obscureText: _isPasswordObscured,
              suffixIcon:
                  _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
              onSuffixIconTap: _togglePasswordVisibility,
            ),
            const SizedBox(height: 16),
            CustomTextFieldWidget(
              controller: _confirmPasswordController,
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
              prefixIcon: Icons.lock,
              obscureText: _isConfirmPasswordObscured,
              suffixIcon: _isConfirmPasswordObscured
                  ? Icons.visibility_off
                  : Icons.visibility,
              onSuffixIconTap: _toggleConfirmPasswordVisibility,
            ),
            const SizedBox(height: 16),
            _signUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _signUpButton() => BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return state is RegistrationLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final email = _emailController.text;
                      final password = _passwordController.text;
                      final confirmPassword = _confirmPasswordController.text;
                      context.read<RegistrationBloc>().add(
                            RegistrationButtonPressed(
                              email: email,
                              password: password,
                              confirmPassword: confirmPassword,
                            ),
                          );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                );
        },
      );

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
      ),
    );
  }
}
