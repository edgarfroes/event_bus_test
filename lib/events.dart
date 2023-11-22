import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventsManager extends GetxService {
  @override
  onInit() {
    Get.put(UserNameEvent(), permanent: true);
    Get.put(CurrentAccountBalanceEvent(), permanent: true);
    // TODO: Add more events.

    super.onInit();
  }
}

class UserNameEvent extends Event<String> {}

class CurrentAccountBalanceEvent extends LocallyStoredEvent<double> {
  CurrentAccountBalanceEvent() : super(storageId: 'currentAccountBalance');
}

abstract class Event<T> extends GetxService {
  Event({
    T? initialValue,
  }) : _initialValue = initialValue;

  final T? _initialValue;

  late final Rx<T?> observable = Rx(_initialValue);

  void update(T data) {
    observable.value = data;
  }
}

abstract class LocallyStoredEvent<T> extends Event<T> {
  LocallyStoredEvent({
    required this.storageId,
  });

  final String storageId;

  @override
  void onInit() {
    _get();

    super.onInit();
  }

  @override
  void update(T data) {
    _updateOnLocalStorage(data);

    super.update(data);
  }

  Future<void> _get() async {
    observable.value = await _getFromLocalStorage();
  }

  Future<T?> _getFromLocalStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.get(storageId) as T?;
  }

  Future<void> _updateOnLocalStorage(T value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is double) {
      await prefs.setDouble(storageId, value);
    }

    if (value is String) {
      await prefs.setString(storageId, value);
    }
  }
}
