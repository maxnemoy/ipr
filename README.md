# ИПР

### Algorithms

[алгоритмы](./alg/)

выглядит так, что сортировки самому писать не стоит =)
список 20к элементов (Ryzen3900x)

bubble sort time: 957 ms
selection sort time: 421 ms
default sort time: 16 ms

bin search index: 332 time: 567 mcs
default search index: 332 time: 84 mcs



### Lifting State Up 

Подход с вынесением логики и данных выше по дереву ранее уже использовал, но не знал, что оно называется именно так

[пример реализации](./lifting_state/)


<details>

  <summary>RIG-10391</summary>

./static/lifting_state.mp4

</details>

Вообще пример высосанный из пальца, самое крутое (на мой взгляд), что я делал используя такой подход - это на прошлом проекте, в мессенджер, для формирования вьюшки сообщения

у нас дано сообщение которое может иметь n типов:
- текстовое
- изображение
- видео
- аудио
- голосовое
- стикер и тд

я реализовал inherited widget MessageData
в нем содержалось все необходимое для построения вьюшки + он был подписан на репозиторий для обновления своих данных и перестройки UI, если сообщение было удалено, отредактировано или, например, не отправилось... 

### Guard clause

Упрощение условий и вложенности, так же всегда использую, но не знал, правильное название этого подхода.
В своей работе стараюсь применять 2 правила: 

- если больше 2 вложенных циклов или условий, скорее всего ты что-то делаешь не так.

- используй else только тогда, когда точно понимаешь, что без него ни как


Плохо

```dart
bool get hasPrivileges{
    if(type !== UserType.user){
        if(type == UserType.admin){
            return true;
        } else if(type == UserType.moder){
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

```

Получше

```dart
bool get hasPrivileges{
    if(type == UserType.user) return;
    
    if(type == UserType.admin || type == UserType.moder){
        return true;
    } 

    return false; 
}

```

Идеально

```dart
bool get hasPrivileges{
    return type == UserType.admin || type == UserType.moder;
}

```

### Golden Test

На проекте покрыл экраны авторизации, регистрации - [пруф](https://github.com/surfstudio/rigla-flutter/pull/2215/files)

### Unit Test

Чиню юниты когда падает ci - [пруф](https://github.com/surfstudio/rigla-flutter/commit/1148fd6ad813faeead22b95757988de1e5e74892)

покрыл алгоритмы юнитами - [пруф](./alg/)

## Обработка ошибок

У меня вопрос был только по Error и Exception
чем отличаются, почему  одни обрабатываются другие нет.

Ответ оказался достаточно прост - Error нужно вообще избегать, а не обрабатывать. Например правильно использовать операторы ? | ! для nullable объектов или внимательно следить за привидением типов.

(пример обработки исключений)[https://github.com/surfstudio/rigla-flutter/blob/_deploy_2.0.28/lib/ui/screen/cart/elementory/cart/application/interactors/cart_interactor/features/error_wrapper.dart]

## CI/CD

В целом, с приходом ci на проект я научился читать логи, детектить и исправлять ошибки.

Базова настраивать уже умел -  [пруф](https://github.com/maxnemoy/ilim_jobs/tree/master/.github/workflows)

Там моно реп, бек + мордочка на flutter

Тригерится по изменениям в соответствующей папке
бек - пушится в отдельную ветку (мне так удобнее, чтобы всегда знать где актуальная версия) и от туда собирается в бинарь и деплоится на сервер

морда - собирается web, статика пушится в отдельную ветку, и от туда деплоится на сервер

## Future

Я не ответил на вопрос "можно ли прерывать операции Future"

Я почитал документации и пришел к выводу, что все-таки нет, нельзя...

Мне однажды нужно было похожее поведение, для этого я просто использовал метод порождающий стрим с async* и yield

## Stream

(дефолтные методы стримов)[./streams]


## Паттерны

### Порождающие паттерны
Простая фабрика https://github.com/surfstudio/rigla-flutter/blob/_deploy_2.0.28/lib/ui/screen/products/presentation/screens/readout/cases/readout_loader.dart

Фабричный метод 
Абстрактная фабрика 
Строитель
Прототип - https://github.com/surfstudio/rigla-flutter/blob/master-rigla/lib/ui/common/widgets/web/html/style/i_custom_style_builder.darti_cutom
Одиночка - https://github.com/surfstudio/rigla-flutter/blob/master-rigla/lib/interactor/common/preferences/varioqub_config_holder.darti_cutom


### Структурные паттерны
Адаптер
Мост
Компоновщик
Декоратор
Фасад - https://github.com/surfstudio/rigla-flutter/blob/master-rigla/lib/interactor/navigation/navigation_interactor.dart
Приспособленец
Заместитель

### Поведенческие паттерны
Команда
Итератор
Посредник
Хранитель
Наблюдатель - https://github.com/surfstudio/rigla-flutter/blob/_deploy_2.0.28/lib/ui/screen/cart/elementory/cart/application/interactors/cart_interactor/features/manage_region.dart#L16
Посетитель
Стратегия
Состояние
Шаблонный метод - https://github.com/surfstudio/rigla-flutter/blob/master-rigla/lib/ui/screen/products/presentation/screens/readout/cases/common/base_filtred_load.dart

## RX Dart

Рефакторил [корзину](https://github.com/surfstudio/rigla-flutter/tree/_deploy_2.0.28/lib/ui/screen/cart/elementory/cart/application/interactors/cart_interactor)
в ней очень много стримов, используется skip, merge, seeded, debounceTime, listen
так же изучал основные методы в https://rxmarbles.com/_