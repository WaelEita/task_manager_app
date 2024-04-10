import '../../data/repositories/task_repository.dart';
import '../../utils/base_cubit.dart';
import 'task_state.dart';

class TaskCubit extends BaseCubit<TaskState> {
  final TaskRepository _taskRepository;

  TaskCubit(this._taskRepository) : super(TaskInitial());

  void getAllTasks() async {
    handleApiCall(() async {
      final tasks = await _taskRepository.getAllTasks();
      emit(TaskLoaded(tasks));
    });
  }

  void getTaskById(int id) async {
    handleApiCall(() async {
      final task = await _taskRepository.getTaskById(id);
      emit(TaskLoaded([task]));
    });
  }

  void getTasksByUserId(int userId) async {
    handleApiCall(() async {
      final tasks = await _taskRepository.getTasksByUserId(userId);
      emit(TaskLoaded(tasks));
    });
  }

  void addTask(String todo, bool completed, int userId) async {
    handleApiCall(() async {
      final task = await _taskRepository.addTask(todo, completed, userId);
      emit(TaskAdded(task));
    });
  }

  void updateTaskStatus(int id, bool completed) async {
    handleApiCall(() async {
      final task = await _taskRepository.updateTask(id, completed);
      emit(TaskUpdated(task));
    });
  }

  void deleteTask(int id) async {
    handleApiCall(() async {
      final task = await _taskRepository.deleteTask(id);
      emit(TaskDeleted(task));
    });
  }
}
