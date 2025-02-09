# bradderly

프로젝트 실행을 위해 fvm 설치 및 빌드러너를 돌려야 합니다.

### install fvm

brew tap leoafarias/fvm  
brew install fvm  
fvm use

### build_runner

fvm dart run build_runner build --delete-conflicting-outputs

### locale

'text'.tr(context)

### 프로젝트 구조

클린 아키텍처 적용

- core
  - di
  - recorder
- data
  - api ( remote_data_source 생략 )
  - isar ( local_data_source 생략 )
  - repository
- domain
  - model
  - repository
  - usecase
- presentation
  - common ( 피쳐별 공통 사용 하는 항목 )
    - extension
    - util
    - locale
    - widget
    - cubit
    - bloc
    - model
  - feature
    - ...
  - generated ( build runner의 결과물로 생긴 파일 )
    - assets
    - i18n
  - theme ( 디자인 시스템의 컬러, 폰트 관리 )
    - color
    - text_style
  - router ( 라우팅 정의 )

상태관리 BLOC  
의존성관리 GetIt ( Injectable로 build runner 돌려서 의존성 주입 )
라우트관리 GoRouter ( build runner 사용 typed safe route 사용중 )
Domain Momain을 View에서도 사용 하되 필요에따라 View Model을 생성하여 사용한다.

### Feature 구조

- input
  - intake_input
    - widget
      - intake_input_beverage_type_widget.dart
    - intake_input_view.dart
    - intake_input_builder.dart
  - manual_input
    ...
  - sound_input_note
    ...
  - sound_input_record
    ...
  - widget
    - input_field_widget.dart
  - formatter
    ...

공통적으로 사용해야하는 항목은 feature 루트 폴더
피쳐 내부에서만 사용해야하는 경우 해당 피쳐 내부 폴더
builder파일은 view파일의 의존성 정의 및 주입을 위해 존재함
파일 및 클래스명은 되도록 피쳐 이름을 prfix로 붙혀서 사용하도록 함  
( ex: input_field_widget.dart, intake_input_beverage_type_widget.dart )
