📱 HOME MODULE – ARCHITECTURE (Motiva)
1. Цел на модулот

Home модулот е главниот dashboard екран на апликацијата Motiva.

Тука корисникот:

добива поздрав (Greeting)
гледа дневен цитат
избира психоедукативни теми
добива брз пристап до coping screens
добива „safe message“
2. Структура на фолдерот
lib/features/home/

├── data/
│   ├── home_navigation_items.dart
│   └── quotes.dart
│
├── widgets/
│   ├── greeting_card.dart
│   ├── help_card.dart
│   ├── quote_card.dart
│   └── safe_card.dart
│
├── screens/
│   └── home_screen.dart
│
└── home_exports.dart
3. DATA слој
3.1 quotes.dart

Патека:

lib/features/home/data/quotes.dart
Улога:

Чува листа од мотивациски цитати.

Структура:
quote (String)
author (String)
Функција:
користи random quote на HomeScreen
дава емоционална поддршка на корисникот
Напомена:

Ова е само data слој (без UI логика)

3.2 home_navigation_items.dart

Патека:

lib/features/home/data/home_navigation_items.dart
Улога:

Дефинира психоедукативни навигациски карти.

Структура:
icon (IconData)
title (String)
screen (Widget)
Функција:
дефинира help topics
секој item води до различен screen
Напомена:

Ова е routing configuration за Home UI

4. WIDGET слој
4.1 greeting_card.dart

Патека:

lib/features/home/widgets/greeting_card.dart
Улога:

Прикажува персонализиран поздрав.

Логика:
чита системско време
враќа:
утро
ден
вечер
Напомена:

UI компонент без state management

4.2 help_card.dart

Патека:

lib/features/home/widgets/help_card.dart
Улога:

Clickable навигациска картичка.

Содржи:
icon
title
screen
Функција:
onTap → Navigator.push()
отвора нов screen
Напомена:

UI + navigation trigger

4.3 quote_card.dart

Патека:

lib/features/home/widgets/quote_card.dart
Улога:

Прикажува дневен цитат.

Содржина:
quote
author
Напомена:

Чист UI component

4.4 safe_card.dart

Патека:

lib/features/home/widgets/safe_card.dart
Улога:

Safety reminder картичка.

Порака:
You are safe
This will pass
Напомена:

Emotional grounding UI component

5. SCREEN слој
5.1 home_screen.dart

Патека:

lib/features/home/screens/home_screen.dart
Улога:

Главен dashboard екран.

Функции:
State management:
random quote (иницијализиран во initState)
UI композиција:
GreetingCard
HelpCards (navigation items)
QuoteCard
SafeCard
Flow:
HomeScreen
   ↓
GreetingCard
   ↓
HelpCards (psychoeducation items)
   ↓
QuoteCard (random)
   ↓
SafeCard
6. home_exports.dart

Патека:

lib/features/home/home_exports.dart
Улога:

Barrel file за централизирани imports.

Предност:

Наместо повеќе import-и:

import 'widgets/greeting_card.dart';
import 'widgets/help_card.dart';
import 'widgets/quote_card.dart';

се користи:

import '../home_exports.dart';
7. Поврзаност на системот
quotes.dart
     ↓
HomeScreen (random selection)
     ↓
home_navigation_items.dart
     ↓
HelpCard UI
     ↓
Psychoeducation screens
8. Clean Architecture логика
DATA слој:
quotes.dart
home_navigation_items.dart
UI слој:
greeting_card
help_card
quote_card
safe_card
PRESENTATION слој:
home_screen.dart