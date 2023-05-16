
abstract class RegisterStates {}

class RegisterInitialStates extends RegisterStates {}

class RegisterLoadingStates extends RegisterStates {}
class RegisterSuccessStates extends RegisterStates {}
class RegisterErrorStates extends RegisterStates {
  String error;
  RegisterErrorStates(this.error);
}

class CreateUserSuccessStates extends RegisterStates {}
class CreateUserErrorStates extends RegisterStates {
  String error;
  CreateUserErrorStates(this.error);
}


class RegisterChangePasswordShowStates extends RegisterStates {}
