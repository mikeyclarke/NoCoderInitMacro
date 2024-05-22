# NoCoderInitMacro

A Swift Macro that adds an unimplemented `init(coder:)` to your classes so that you don’t have to.

## Installation

NoCoderInitMacro is installable using Swift Package Manager.

Add to your `package.swift`

```
.package(url: "https://github.com/mikeyclarke/NoCoderInitMacro.git", from: "1.0.0"),
```

Or through the Xcode UI:

- “Add Package Dependency…” (currently available from the File menu or in the right-click menu in the File Navigator)
- Enter the URL of this repository: `https://github.com/mikeyclarke/NoCoderInitMacro.git`
- Choose "Up To Next Major Version": 1.0.0

## Usage

Import the macro and then simply annotate any class that needs an `init(coder:)` with `@NoCoderInit`.

```swift
import NoCoderInitMacro

@NoCoderInit
class ViewController: PlatformViewController {
    init() {
        // …
    }
}

// Expands to:

class ViewController: PlatformViewController {
    init() {
        // …
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

## Alternatives

There are [various alternatives](https://www.swiftbysundell.com/tips/handling-view-controllers-that-have-custom-initializers/) to adding the unimplemented initializer.

## License

NoCoderInitMacro is available under the MIT license. See [LICENSE](LICENSE) for details.
