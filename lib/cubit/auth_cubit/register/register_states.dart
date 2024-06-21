abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterFailureState extends RegisterStates {}

class AddFCMTokenLoading extends RegisterStates {}

class AddFCMTokenSuccess extends RegisterStates {}

class AddFCMTokenFailure extends RegisterStates {}

class ChangeRegisterPasswordVisibility extends RegisterStates {}
