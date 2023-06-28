# MixedApp Example

## Problem to solve

This example show how to mix SwiftUI views with complex navigation

## Solution detail

This sample uses a SwiftUI view as part of a classic view controller structure:
```
ViewController
    View
        SwiftUI View Model
            SwiftUI View
```

All of this make possible to implement complex navigation flows thanks to `Coordinator` Pattern