// BUBBLE SORT
import 'dart:async';

bubbleSort(
    List<int> _numbers, StreamController<List<int>> _streamController) async {
  for (int i = 0; i < _numbers.length; ++i) {
    for (int j = 0; j < _numbers.length - i - 1; ++j) {
      if (_numbers[j] > _numbers[j + 1]) {
        int temp = _numbers[j];
        _numbers[j] = _numbers[j + 1];
        _numbers[j + 1] = temp;
      }
      await Future.delayed(const Duration(microseconds: 30000));
      _streamController.add(_numbers);
    }
  }
}

cf(int a, int b) {
  if (a < b) {
    return -1;
  } else if (a > b) {
    return 1;
  } else {
    return 0;
  }
}

// QUICK SORT
quickSort(
    int leftIndex, int rightIndex, _numbers, _streamController, val) async {
  Future<int> _partition(int left, int right) async {
    int p = (left + (right - left) / 2).toInt();

    var temp = _numbers[p];
    _numbers[p] = _numbers[right];
    _numbers[right] = temp;
    await Future.delayed(Duration(microseconds: val), () {});

    _streamController.add(_numbers);

    int cursor = left;

    for (int i = left; i < right; i++) {
      if (cf(_numbers[i], _numbers[right]) <= 0) {
        var temp = _numbers[i];
        _numbers[i] = _numbers[cursor];
        _numbers[cursor] = temp;
        cursor++;
        await Future.delayed(Duration(microseconds: val), () {});
        _streamController.add(_numbers);
      }
    }

    temp = _numbers[right];
    _numbers[right] = _numbers[cursor];
    _numbers[cursor] = temp;
    await Future.delayed(Duration(microseconds: val), () {});
    _streamController.add(_numbers);
    return cursor;
  }

  if (leftIndex < rightIndex) {
    int p = await _partition(leftIndex, rightIndex);

    await quickSort(leftIndex, p - 1, _numbers, _streamController, val);

    await quickSort(p + 1, rightIndex, _numbers, _streamController, val);
  }
}

// INSERTION SORT
insertionSort(_numbers, _streamController, val) async {
  for (int i = 1; i < _numbers.length; i++) {
    int temp = _numbers[i];
    int j = i - 1;
    while (j >= 0 && temp < _numbers[j]) {
      _numbers[j + 1] = _numbers[j];
      --j;
      await Future.delayed(Duration(microseconds: val), () {});

      _streamController.add(_numbers);
    }
    _numbers[j + 1] = temp;
    await Future.delayed(Duration(microseconds: val), () {});

    _streamController.add(_numbers);
  }
}

// MERGE SORT
mergeSort(
    int leftIndex, int rightIndex, _numbers, _streamController, val) async {
  Future<void> merge(int leftIndex, int middleIndex, int rightIndex) async {
    int leftSize = middleIndex - leftIndex + 1;
    int rightSize = rightIndex - middleIndex;

    List<int> leftList = List<int>.generate(leftSize, (index) => index);
    List<int> rightList = List<int>.generate(rightSize, (index) => index);

    for (int i = 0; i < leftSize; i++) leftList[i] = _numbers[leftIndex + i];
    for (int j = 0; j < rightSize; j++)
      rightList[j] = _numbers[middleIndex + j + 1];

    int i = 0, j = 0;
    int k = leftIndex;

    while (i < leftSize && j < rightSize) {
      if (leftList[i] <= rightList[j]) {
        _numbers[k] = leftList[i];
        i++;
      } else {
        _numbers[k] = rightList[j];
        j++;
      }

      await Future.delayed(Duration(microseconds: val), () {});
      _streamController.add(_numbers);

      k++;
    }
    // ExpansionPanelList;
    while (i < leftSize) {
      _numbers[k] = leftList[i];
      i++;
      k++;

      await Future.delayed(Duration(microseconds: val), () {});
      _streamController.add(_numbers);
    }

    while (j < rightSize) {
      _numbers[k] = rightList[j];
      j++;
      k++;

      await Future.delayed(Duration(microseconds: val), () {});
      _streamController.add(_numbers);
    }
  }

  if (leftIndex < rightIndex) {
    int middleIndex = (rightIndex + leftIndex) ~/ 2;

    await mergeSort(leftIndex, middleIndex, _numbers, _streamController, val);
    await mergeSort(
        middleIndex + 1, rightIndex, _numbers, _streamController, val);

    await Future.delayed(Duration(microseconds: val), () {});

    _streamController.add(_numbers);

    await merge(leftIndex, middleIndex, rightIndex);
  }
}

// SELECTION SORT
selectionSort(_numbers, _streamController, val) async {
  for (int i = 0; i < _numbers.length; i++) {
    for (int j = i + 1; j < _numbers.length; j++) {
      if (_numbers[i] > _numbers[j]) {
        int temp = _numbers[j];
        _numbers[j] = _numbers[i];
        _numbers[i] = temp;
      }

      await Future.delayed(Duration(microseconds: 30000), () {});
      _streamController.add(_numbers);
    }
  }
}

// HEAP SORT
heapSort(_numbers, _streamController, val) async {
  for (int i = _numbers.length ~/ 2; i >= 0; i--) {
    await heapify(_numbers, _numbers.length, i, val);
    _streamController.add(_numbers);
  }
  for (int i = _numbers.length - 1; i >= 0; i--) {
    int temp = _numbers[0];
    _numbers[0] = _numbers[i];
    _numbers[i] = temp;
    await heapify(_numbers, i, 0, val);
    _streamController.add(_numbers);
  }
}

heapify(List<int> arr, int n, int i, val) async {
  int largest = i;
  int l = 2 * i + 1;
  int r = 2 * i + 2;

  if (l < n && arr[l] > arr[largest]) largest = l;

  if (r < n && arr[r] > arr[largest]) largest = r;

  if (largest != i) {
    int temp = arr[i];
    arr[i] = arr[largest];
    arr[largest] = temp;
    heapify(arr, n, largest, val);
  }
  await Future.delayed(Duration(microseconds: val), () {});
}
