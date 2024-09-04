import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:llearning/features/Mylearnings/domain/usecases/my_learning_use_case.dart';
import 'package:llearning/features/Mylearnings/presentation/state/my_learning_state.dart';
final myLearningViewModelProvider=StateNotifierProvider<MyLearningViewModel,EnrolledState>(
    (ref)=> MyLearningViewModel(ref.read(myLearningUsercaseProvider))
);
class MyLearningViewModel extends StateNotifier<EnrolledState>{
  final MyLearningUseCase useCase;
  MyLearningViewModel(this.useCase):super(EnrolledState.initial()){
    getLearning();
  }

  Future<void> getLearning()async{
    state = state.copyWith(isLoading: true);
    final result=await useCase.getLearnings();
    result.fold(
        (failure)=>state=state.copyWith(isLoading: false,error: failure.error),
        (enrolled)=>state=state.copyWith(isLoading: false,enrolled: enrolled));
  }
}