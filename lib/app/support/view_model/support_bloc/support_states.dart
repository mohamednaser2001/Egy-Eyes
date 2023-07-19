


abstract class SupportStates {}
class InitialSupportState extends SupportStates{}
class ChangeSupportScreenTypeState extends SupportStates{}
class ToggleBetweenAddAndSupportDataState extends SupportStates{}

class ChangeGovernorateState extends SupportStates{}
class ChangeCityState extends SupportStates{}
class ChangeStatusState extends SupportStates{}
class ChangeSupportTypeState extends SupportStates{}
class SupportImagePickedSuccess extends SupportStates{}
class AddSupportSuccessState extends SupportStates{}
class AddSupportLoadingState extends SupportStates{}
class ChangeLatLongState extends SupportStates{}
class GetSupportsSuccessState extends SupportStates{}


class GetAllSupportsSuccessState extends SupportStates{}
class GetAllSupportsErrorState extends SupportStates{}
class GetAllSupportsLoadingState extends SupportStates{}

class SendSupportLoadingState extends SupportStates{}
class SendSupportSuccessState extends SupportStates{}
class SendSupportErrorState extends SupportStates{}


class SendFakeLoadingState extends SupportStates{}
class SendFakeSuccessState extends SupportStates{}
class SendFakeErrorState extends SupportStates{}