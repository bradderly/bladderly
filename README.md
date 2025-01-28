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
    - generated ( build runner의 결과물로 생긴 파일 )
      - assets
      - i18n
  - theme ( 디자인 시스템의 컬러, 폰트 관리 )
    - color
    - text_style

상태관리 BLOC  
의존성관리 GetIt ( Injectable로 build runner 돌려서 의존성 주입 )
라우트관리 GoRouter ( build runner 사용 typed safe route 사용중 )
Domain Momain을 View에서도 사용 하되 필요에따라 View Model을 생성하여 사용한다.
