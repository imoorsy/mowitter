
abstract class LoginStates {}

class LoginInitialStates extends LoginStates {}

class LoginLoadingStates extends LoginStates {}
class LoginSuccessStates extends LoginStates {}
class LoginErrorStates extends LoginStates {
  final String error;
  LoginErrorStates(this.error);
}


class LoginChangePasswordShowStates extends LoginStates {}
