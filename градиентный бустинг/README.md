## Задача: Необходимо построить модель для определения стоимости авто по историческим данным.
### План
      1. Загрузим и подготовим данные.
      2. Обучим разные модели. Для каждой попробуем различные гипепараметеры.
      3. Проанализируем скорость работы и качество моделей.
### Решил поставленную задачу использовав библиотеку `lightgbm`. Она показала достойный результат: `RMSE = 276` на тестовой выборке (при средней стоимости для выборки `Price = 5504`), несмотря на малое время обучения.
