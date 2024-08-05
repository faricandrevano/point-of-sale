part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  const OnboardingState({this.pageIndex = 0});
  final int pageIndex;
  @override
  List<Object> get props => [pageIndex];
}
