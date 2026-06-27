# 🌬 BREATHING MODULE – ARCHITECTURE (Motiva)

# 1. Цел на модулот

Breathing модулот обезбедува водени техники на дишење за:

* намалување на анксиозност
* активација на парасимпатички нервен систем
* подобрување на концентрација
* регулација на стрес
* подготовка за SOS модулот

---

# 2. Структура на фолдерот

breathing/

├── data/
│   ├── breathing_assets.dart
│   ├── breathing_config.dart
│   └── breathing_techniques.dart
│
├── models/
│   └── breathing_technique.dart
│
├── services/
│   └── breathing_engine.dart
│
├── widgets/
│   ├── breathing_circle.dart
│   ├── breathing_cycle_counter.dart
│   └── breathing_phase_text.dart
│
└── screens/
├── breathing_home_screen.dart
├── breathing_player_screen.dart
└

---

# 3. DATA слој

## 3.1 breathing_technique.dart

Патека

models/breathing_technique.dart

Улога

Модел кој дефинира техника на дишење.

Содржи

id

name

inhaleSeconds

holdSeconds

exhaleSeconds

cycles

---

## 3.2 breathing_techniques.dart

Патека

data/breathing_techniques.dart

Улога

Листа на сите техники достапни во апликацијата.

Моментално

✔ Box Breathing

✔ Relaxing Breathing

✔ 4-7-8 Breathing

✔ Resonance Breathing

Идни техники

// 6-2-8

// Triangle

// Coherent

// Pursed Lip

---

## 3.3 breathing_assets.dart

Патека

data/breathing_assets.dart

Улога

Чува патеки до аудио ресурси.

Пример

inhale.mp3

hold.mp3

exhale.mp3

session_complete.mp3

---

## 3.4 breathing_config.dart

Патека

data/breathing_config.dart

Улога

Глобални конфигурации за breathing module.

Пример

animationDuration

defaultCycles

circleMaxSize

circleMinSize

---

# 4. SERVICE слој

## breathing_engine.dart

Улога

Core логика за сите breathing техники.

Функции

start()

stop()

dispose()

Следи

INHALE

HOLD

EXHALE

Менува

currentCycle

phase

Повик

BreathingEngine.fromTechnique()

Ова овозможува истиот engine да се користи за сите breathing техники.

---

# 5. WIDGET слој

## breathing_circle.dart

Улога

Анимиран круг.

Однесување

Inhale

расте

Hold

стои

Exhale

се намалува

---

## breathing_phase_text.dart

Улога

Прикажува моментална фаза.

Пример

INHALE

Breathe in slowly

EXHALE

Release slowly

---

## breathing_cycle_counter.dart

Улога

Прикажува прогрес.

Пример

Cycle 3 / 10

LinearProgressIndicator

---

# 6. SCREEN слој

## breathing_home_screen.dart

Улога

Мену со сите техники.

Содржи

Box Breathing

Relaxing Breathing

4-7-8

Resonance

Во иднина

Triangle

Coherent

Pursed Lip

---

## breathing_player_screen.dart

Улога

Универзален екран за извршување на техника.

Прима

BreathingTechnique

Креира

BreathingEngine.fromTechnique()

Користи

BreathingCircle

BreathingPhaseText

BreathingCycleCounter

---




breathing_player_screen.dart

---

# 7. Поврзаност

breathing_home_screen

↓

BreathingTechnique

↓

BreathingEngine

↓

BreathingCircle

↓

BreathingPhaseText

↓

BreathingCycleCounter

---

# 8. Идно проширување

🎵 амбиентални звуци

📳 вибрација

🔊 гласовни инструкции

⭐ favorite techniques

📈 breathing statistics

🚨 интеграција со SOS

🧠 адаптивен избор на техника според симптоми

---

# 9. Clean Architecture

DATA

breathing_techniques.dart

breathing_assets.dart

breathing_config.dart

MODEL

breathing_technique.dart

SERVICE

breathing_engine.dart

UI

breathing_circle.dart

breathing_phase_text.dart

breathing_cycle_counter.dart

PRESENTATION

breathing_home_screen.dart

breathing_player_screen.dart
