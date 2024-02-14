# ReadingFrame
책을 기록하기에 가장 적합한 틀, ReadingFrame iOS
<br><br>
## 💻 Coding Convention
<details markdown="1">
<summary> 🖼️ 코드 레이아웃 </summary>

---
### 들여쓰기 및 띄어쓰기
- 콜론(`:`)을 쓸 때에는 콜론의 오른쪽에만 공백을 둡니다.
```swift
let names: [String: String]?
```
- (if, while, for)문 괄호 뒤에 한칸을 띄우고 사용합니다.
```swift
let a = 4 // 양쪽 사이 띄어쓰기
if (a == 4) {
  // doSomething()
}
```
- 연산자 오버로딩 함수 정의에서는 연산자와 괄호 사이에 한 칸 띄어씁니다.
```swift
func ** (lhs: Int, rhs: Int)
```
<br>

### 줄바꿈
- 함수 정의가 최대 길이를 초과하는 경우에는 아래와 같이 줄바꿈합니다.
```swift
func collectionView(
  _ collectionView: UICollectionView,
  cellForItemAt indexPath: IndexPath
) -> UICollectionViewCell {
  // doSomething()
}

func animationController(
  forPresented presented: UIViewController,
  presenting: UIViewController,
  source: UIViewController
) -> UIViewControllerAnimatedTransitioning? {
  // doSomething()
}
```
- 함수를 호출하는 코드가 최대 길이를 초과하는 경우에는 파라미터 이름을 기준으로 줄바꿈합니다.
```swift
let actionSheet = UIActionSheet(
  title: "정말 계정을 삭제하실 건가요?",
  delegate: self,
  cancelButtonTitle: "취소",
  destructiveButtonTitle: "삭제해주세요"
)
```
단, 파라미터에 클로저가 2개 이상 존재하는 경우에는 무조건 내려쓰기합니다.
```swift
UIView.animate(
  withDuration: 0.25,
  animations: {
    // doSomething()
  },
  completion: { finished in
    // doSomething()
  }
)
```
- `if let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다.
```swift
if let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
   let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
  user.gender == .female {
  // ...
}
```
- `guard let` 구문이 길 경우에는 줄바꿈하고 한 칸 들여씁니다. `else`는 `guard`와 같은 들여쓰기를 적용합니다.
```swift
guard let user = self.veryLongFunctionNameWhichReturnsOptionalUser(),
      let name = user.veryLongFunctionNameWhichReturnsOptionalName(),
      user.gender == .female
else {
  return
}
```
<br>

### 최대 줄 길이
- 한 줄은 최대 99자를 넘지 않아야 합니다.
<br>

### 빈 줄
- 빈 줄에는 공백이 포함되지 않도록 합니다.
- 모든 파일은 빈 줄로 끝나도록 합니다.
- MARK 구문 위와 아래에는 공백이 필요합니다.

```swift
// MARK: Layout

override func layoutSubviews() {
  // doSomething()
}

// MARK: Actions

override func menuButtonDidTap() {
  // doSomething()
}
```
<br>

### 임포트
- 모듈 임포트는 알파벳 순으로 정렬합니다. 내장 프레임워크를 먼저 임포트하고, 빈 줄로 구분하여 서드파티 프레임워크를 임포트합니다.
```swift
import SwiftUI

import SwiftyColor
import SwiftyImage
import Then
import URLNavigator
```
---

</details>

<details markdown="1">
<summary> ✏️ 네이밍 </summary>
  
---
### 클래스와 구조체
- 클래스와 구조체의 이름에는 `UpperCamelCase`를 사용합니다.
- 클래스 이름에는 `접두사Prefix`를 붙이지 않습니다.
<br>

### 약어
- **약어로 시작하는 경우 소문자**로 표기하고, 그 외의 경우에는 **항상 대문자**로 표기합니다.<br><br>
  - 예시<br><br>
    btn -> **`Btn`**<br><br>
    image -> **`Img`**<br><br>
    userId -> **`userID`**<br><br>
    password -> **`PWD`**<br><br>
    websiteUrl -> **`websiteURL`**<br><br>

### 함수
- 함수 이름에는 `lowerCamelCase`를 사용합니다.
- 함수 이름 앞에는 되도록이면 `get`을 붙이지 않습니다.<br><br>

  **좋은 예:**
  ```swift
  func name(for user: User) -> String?
  ```
  **나쁜 예:**
  ```swift
  func getName(for user: User) -> String?
  ```
- Action 함수의 네이밍은 **`'주어 + 동사 + 목적어'`** 형태를 사용합니다.
    - <b>Tap(눌렀다 뗌)</b>은 `UIControlEvents`의 `.touchUpInside`에 대응하고, <b>Press(누름)</b>는 `.touchDown`에 대응합니다.
    - **will~**은 특정 행위가 일어나기 직전이고, **did~**는 특정 행위가 일어난 직후입니다.
    - **should~**는 일반적으로 `Bool`을 반환하는 함수에 사용됩니다.<br><br>
    
  **좋은 예:**
    ```swift
    func backButtonDidTap() {
      // ...
    }
    ```
    **나쁜 예:**
    ```swift
    func back() {
      // ...
    }

    func pressBack() {
      // ...
    }
    ```
<br>

### 변수
- 변수 이름에는 `lowerCamelCase`를 사용합니다.
<br>

### 상수
- 상수 이름에는 `lowerCamelCase`를 사용합니다.<br><br>

  **좋은 예:**
  ```swift
  let maximumNumberOfLines = 3
  ```
  **나쁜 예:**
  ```swift
  let MaximumNumberOfLines = 3
  let MAX_LINES = 3
  ```
<br>

### 열거형
- enum의 이름에는 `UpperCamelCase`를 사용합니다.
- enum의 각 case에는 `lowerCamelCase`를 사용합니다.<br><br>

  **좋은 예:**
  ```swift
  enum Result {
    case .success
    case .failure
  }
  ```
  **나쁜 예:**
  ```swift
  enum Result {
    case .Success
    case .Failure
  }
  
  enum result {
    case .Success
    case .Failure
  }
  ```
<br>

### 프로토콜
- 프로토콜의 이름에는 `UpperCamelCase`를 사용합니다.
- 구조체나 클래스에서 프로토콜을 채택할 때는 콜론(`:`)과 빈칸을 넣어 구분하여 명시합니다.<br><br>

  **좋은 예:**
  ```swift
  protocol SomeProtocol {
    // protocol definition goes here
  }

  struct SomeStructure: SomeProtocol, AnotherProtocol {
    // structure definition goes here
  }

  class SomeClass: SomeSuperclass, SomeProtocol, AnotherProtocol {
  // class definition goes here
  }

  extension UIViewController: SomeProtocol, AnotherProtocol {
    // doSomething()
  }
  ```
<br>

### Delegate
- Delegate 메서드는 프로토콜명으로 네임스페이스를 구분합니다.<br><br>

    **좋은 예:**
    ```swift
    protocol UserCellDelegate {
      func userCellDidSetProfileImage(_ cell: UserCell)
      func userCell(_ cell: UserCell, didTapFollowButtonWith user: User)
    }
    ```
    **나쁜 예:**
    ```swift
    protocol UserCellDelegate {
      func didSetProfileImage()
      func followPressed(user: User)
    
      // `UserCell`이라는 클래스가 존재할 경우 컴파일 에러 발생
      func UserCell(_ cell: UserCell, didTapFollowButtonWith user: User)
    }
    ```
---

</details>

<details markdown="1">
<summary> 📢 주석 </summary>

---
- `///`를 사용해서 문서화에 사용되는 주석을 남깁니다.
- 예를 들어, 파일에 대한 설명, 변수 및 상수에 대한 설명을 주석으로 남깁니다.
  
    ```swift
    /// 사용자 프로필을 그려주는 뷰
    class ProfileView: UIView {
    
      /// 사용자 닉네임을 그려주는 라벨
      var nameLabel: UILabel!
    }
    ```
    
- `// MARK:`를 사용해서 코드의 구역이나 단위를 시각적으로 구분짓습니다.<br>
  
    ```swift
    
    // MARK: 홈 화면, 책장 화면 전환 버튼
    HomeSegmentedControl()
      .frame(width: 118, height: 28)
      .padding(.top, 15)
    
    // MARK: 읽고 있는 책
    HStack {
      Text("읽고 있는 책")
        .font(.thirdTitle)
        .foregroundStyle(.black0)
                    
      Text("\(readingBooksCount)")
        .font(.thirdTitle)
        .foregroundStyle(.black0)
    }
    ```
---
  
</details>

<details markdown="1">
<summary> 🎸 기타 사항 </summary>

---
### 클래스와 구조체
- 클래스와 구조체 내부에서는 `self`를 명시적으로 사용합니다.
- 구조체를 생성할 때에는 Swift 구조체 생성자를 사용합니다.

    **좋은 예:**
    ```swift
    let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    ```
    **나쁜 예:**
    ```swift
    let frame = CGRectMake(0, 0, 100, 100)
    ```
<br>

### 타입
- `Array<T>`와 `Dictionary<T: U>` 보다는 `[T]`, `[T: U]`를 사용합니다.
    
    **좋은 예:**
    ```swift
    var messages: [String]?
    var names: [Int: String]?
    ```
    **나쁜 예:**
    ```swift
    var messages: Array<String>?
    var names: Dictionary<Int, String>?
    ```
<br>

### 클로저
- 파라미터와 리턴 타입이 없는 Closure 정의시에는 `() -> Void`를 사용합니다.<br><br>

    **좋은 예:**
    ```swift
    let completionBlock: (() -> Void)?
    ```
    **나쁜 예:**
    ```swift
    let completionBlock: (() -> ())?
    let completionBlock: ((Void) -> (Void))?
    ```
- Closure 정의시 파라미터에는 괄호를 사용하지 않습니다.<br><br>

    **좋은 예:**
    ```swift
    { operation, responseObject in
      // doSomething()
    }
    ```
    **나쁜 예:**
    ```swift
    { (operation, responseObject) in
      // doSomething()
    }
    ```
- Closure 정의시 가능한 경우 타입 정의를 생략합니다.<br><br>

    **좋은 예:**
    ```swift
    ...,
    completion: { finished in
      // doSomething()
    }
    ```
    **나쁜 예:**
    ```swift
    ...,
    completion: { (finished: Bool) -> Void in
      // doSomething()
    }
    ```
- Closure 호출시 또다른 유일한 Closure를 마지막 파라미터로 받는 경우, 파라미터 이름을 생략합니다.<br><br>

    **좋은 예:**
    ```swift
    UIView.animate(withDuration: 0.5) {
      // doSomething()
    }
    ```
    **나쁜 예:**
    ```swift
    UIView.animate(withDuration: 0.5, animations: { () -> Void in
      // doSomething()
    })
    ```
---

</details>
<br>

## ✉️ Commit Convention
`타입: 부연 설명 및 이유 #이슈번호` `ex. Feat: Home 화면 UI 구현 #1`

```
Feat: 새로운 기능 추가
Fix: 버그 수정
Build: 빌드 관련 파일 수정
Chore: 그 외 자잘한 수정
Ci: CI관련 설정 수정
Docs: Wiki, README 문서 (문서 추가 수정, 삭제)
Style: 스타일 (코드 형식, 세미콜론 추가, 비즈니스 로직 변경X)
Refactor: 리팩토링 (네이밍 변경  포함)
Test: 테스트 코드 (추가, 수정, 삭제)
```
