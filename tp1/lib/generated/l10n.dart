// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();
  
  static S? current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current!;
    });
  } 

  static S? of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Task List`
  String get taskList {
    return Intl.message(
      'Task List',
      name: 'taskList',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get addTask {
    return Intl.message(
      'Add Task',
      name: 'addTask',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `It looks like you don't have any tasks.`
  String get noTasksFound {
    return Intl.message(
      'It looks like you don\'t have any tasks.',
      name: 'noTasksFound',
      desc: '',
      args: [],
    );
  }

  /// `There was an error communicating with the server, please try again.`
  String get serverError {
    return Intl.message(
      'There was an error communicating with the server, please try again.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Progress`
  String get progress {
    return Intl.message(
      'Progress',
      name: 'progress',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get taskDetailsTitle {
    return Intl.message(
      'Task Details',
      name: 'taskDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Name: `
  String get taskName {
    return Intl.message(
      'Name: ',
      name: 'taskName',
      desc: '',
      args: [],
    );
  }

  /// `Elapsed Time: `
  String get elapsedTime {
    return Intl.message(
      'Elapsed Time: ',
      name: 'elapsedTime',
      desc: '',
      args: [],
    );
  }

  /// `Due Date: `
  String get dueDate {
    return Intl.message(
      'Due Date: ',
      name: 'dueDate',
      desc: '',
      args: [],
    );
  }

  /// `Update Progress`
  String get updateProgressButton {
    return Intl.message(
      'Update Progress',
      name: 'updateProgressButton',
      desc: '',
      args: [],
    );
  }

  /// `Upload Image`
  String get uploadImageButton {
    return Intl.message(
      'Upload Image',
      name: 'uploadImageButton',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get goBackButton {
    return Intl.message(
      'Go Back',
      name: 'goBackButton',
      desc: '',
      args: [],
    );
  }

  /// `Hard Delete`
  String get hardDeleteButton {
    return Intl.message(
      'Hard Delete',
      name: 'hardDeleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Task not found. Please try again.`
  String get taskNotFound {
    return Intl.message(
      'Task not found. Please try again.',
      name: 'taskNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Uploading...`
  String get uploadingInProgress {
    return Intl.message(
      'Uploading...',
      name: 'uploadingInProgress',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get createTaskTitle {
    return Intl.message(
      'Create Task',
      name: 'createTaskTitle',
      desc: '',
      args: [],
    );
  }

  /// `Task Name`
  String get taskNameLabel {
    return Intl.message(
      'Task Name',
      name: 'taskNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Date`
  String get pickDateButton {
    return Intl.message(
      'Pick a Date',
      name: 'pickDateButton',
      desc: '',
      args: [],
    );
  }

  /// `Add Task`
  String get addTaskButton {
    return Intl.message(
      'Add Task',
      name: 'addTaskButton',
      desc: '',
      args: [],
    );
  }

  /// `Select Due Date`
  String get selectDueDate {
    return Intl.message(
      'Select Due Date',
      name: 'selectDueDate',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a task name`
  String get emptyFieldError {
    return Intl.message(
      'Please enter a task name',
      name: 'emptyFieldError',
      desc: '',
      args: [],
    );
  }

  /// `Task added successfully!`
  String get taskAddedSuccess {
    return Intl.message(
      'Task added successfully!',
      name: 'taskAddedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add task. Please try again.`
  String get taskAddFailure {
    return Intl.message(
      'Failed to add task. Please try again.',
      name: 'taskAddFailure',
      desc: '',
      args: [],
    );
  }

  /// `Please fill all fields.`
  String get fillAllFieldsError {
    return Intl.message(
      'Please fill all fields.',
      name: 'fillAllFieldsError',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a username`
  String get pleaseEnterUsername {
    return Intl.message(
      'Please enter a username',
      name: 'pleaseEnterUsername',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a password`
  String get pleaseEnterPassword {
    return Intl.message(
      'Please enter a password',
      name: 'pleaseEnterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get pleaseConfirmPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'pleaseConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordsDoNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordsDoNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Processing Data...`
  String get processingData {
    return Intl.message(
      'Processing Data...',
      name: 'processingData',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account? Sign up here`
  String get dontHaveAccount {
    return Intl.message(
      'Don\'t have an account? Sign up here',
      name: 'dontHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `User not found. Please try again.`
  String get usernameNotFound {
    return Intl.message(
      'User not found. Please try again.',
      name: 'usernameNotFound',
      desc: '',
      args: [],
    );
  }

  /// `The username is already taken. Please choose another one.`
  String get usernameAlreadyTaken {
    return Intl.message(
      'The username is already taken. Please choose another one.',
      name: 'usernameAlreadyTaken',
      desc: '',
      args: [],
    );
  }

  /// `The username is too short. It must be at least 3 characters.`
  String get usernameTooShort {
    return Intl.message(
      'The username is too short. It must be at least 3 characters.',
      name: 'usernameTooShort',
      desc: '',
      args: [],
    );
  }

  /// `The password is too short. It must be at least 4 characters.`
  String get passwordTooShort {
    return Intl.message(
      'The password is too short. It must be at least 4 characters.',
      name: 'passwordTooShort',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred. Please try again.`
  String get unknownError {
    return Intl.message(
      'An unknown error occurred. Please try again.',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get createTask {
    return Intl.message(
      'Create Task',
      name: 'createTask',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}