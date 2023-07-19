

abstract class LoginStates {}
class InitialLoginState extends LoginStates{}
class SocialAppLoginSuccessState extends LoginStates{
  String userId;
  SocialAppLoginSuccessState(this.userId);
}
class SocialAppLoginErrorState extends LoginStates{
  String error;
  SocialAppLoginErrorState({required this.error});
}
class SocialAppLoginLoadingState extends LoginStates{}
