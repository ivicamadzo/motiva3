📘 PSYCHOEDUCATION MODULE – ARCHITECTURE (Motiva)
1. Цел на модулот

Psychoeducation модулот е систем за:

едукација за анксиозност
разбирање на мисловни модели
нормализација на симптоми
ACT-based психолошки концепти
self-help learning experience
2. Главна архитектура

Модулот е изграден од 3 слоја:

CORE → SCREEN → DATA
3. CORE слој
3.1 PsychoCard model
class PsychoCard {
  final String title;
  final String content;

  const PsychoCard({
    required this.title,
    required this.content,
  });
}
Улога:

Дефинира една страница (slide) во психоедукативен модул.

Структура:
title → наслов на концептот
content → објаснување / едукација
3.2 PsychoeducationScreen (CORE ENGINE)
class PsychoeducationScreen extends StatefulWidget
Улога:

Ова е reusable engine / template за сите psychoeducation екрани.

Функционалност:
1. Page-based learning system
користи PageView
секоја тема е серија од cards
2. State management
_currentPage следи тековна страница
PageController управува навигација
3. UI структура
A) AppBar
динамичен title (зависи од screen)
B) PageView
прикажува PsychoCard страници
swipe navigation
C) Indicator dots
визуелен progress tracker
D) Action button
Next page → или
Finish → Navigator.pop()
Flow:
PsychoeducationScreen
   ↓
PageView
   ↓
PsychoCard pages
   ↓
Dots indicator
   ↓
Next / Finish button
Клучна идеја:

👉 Ова е single reusable UI engine за сите теми

4. DATA слој

Секоја тема има свој dataset.

4.1 Пример: anticipatory_anxiety_data.dart
const anticipatoryAnxietyPages = [
  PsychoCard(...),
];
Улога:
чист content layer
нема UI
нема state
само текст + структура
Содржина:

Секоја тема содржи:

дефиниција
психолошко објаснување
примери
когнитивни механизми
ACT потсетници
coping пораки
Пример категории:
📌 Антиципаторна анксиозност
future fear
prediction anxiety
📌 Социјална анксиозност
fear of judgment
social threat processing
📌 Intrusive thoughts
unwanted thoughts
cognitive defusion
📌 Overthinking
rumination loop
cognitive overload
5. SCREEN слој

Сите screens се thin wrappers над core engine.

Пример:
class AnticipatoryAnxietyScreen extends StatelessWidget {
  const AnticipatoryAnxietyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PsychoeducationScreen(
      title: "Антиципаторна анксиозност",
      pages: anticipatoryAnxietyPages,
    );
  }
}
Улога:
само поврзува:
title
data
template
Архитектурен принцип:

👉 “NO LOGIC IN SCREENS”

6. EXPORT SYSTEM
export 'screens/social_anxiety_screen.dart';
export 'screens/intrusive_thoughts_screen.dart';
export 'screens/anticipatory_anxiety_screen.dart';
export 'screens/overthinking_screen.dart';
export 'screens/fear_of_judgment_screen.dart';
export 'screens/reassurance_screen.dart';
Улога:
централен access point
намалува import хаос
clean feature access
7. NAVIGATION MODEL
Во Psychoeducation системот:
НЕ се користи routes.dart

Наместо тоа:

PsychoeducationNavItem → Widget screen
Model:
class PsychoeducationNavItem {
  final IconData icon;
  final String title;
  final Widget screen;
}
Flow:
Home
 ↓
Psychoeducation Card
 ↓
Screen (direct widget)
 ↓
PsychoeducationScreen engine
 ↓
Pages (PsychoCard list)
8. CLEAN ARCHITECTURE MAP
CORE
PsychoCard
PsychoeducationScreen (engine)
DATA
anticipatory_anxiety_data
social_anxiety_data
intrusive_thoughts_data
overthinking_data
reassurance_data
fear_of_judgment_data
PRESENTATION (SCREENS)
AnticipatoryAnxietyScreen
SocialAnxietyScreen
etc.
EXPORT LAYER
psychoeducation_exports.dart
9. Дизајн принцип
🔥 “One Engine – Many Contents”

👉 Еден UI engine
👉 повеќе психолошки теми
👉 reusable architecture

10. ЗОШТО ОВАА АРХИТЕКТУРА Е ДОБРА
✔️ Предности:
многу scalable
лесно додавање нови теми
нема UI duplication
consistent UX
чист separation of concerns
❌ НЕМА:
hardcoded UI per screen
duplicate layouts
routing complexity
business logic во UI
11. ИДНО ПРОШИРУВАЊЕ
1. Progress tracking
колку cards user поминал
2. Bookmark system
save psychoeducation pages
3. Quiz mode
test understanding
4. Audio narration
TTS за секоја card
5. Analytics
which topics are most used
🚀 ЗАКЛУЧОК

Овој модул е:

👉 REUSABLE EDUCATION ENGINE
👉 не е само UI screens
👉 туку scalable learning system