# MessageVIew
notification message like toast message in android

## At a Glance
```
let msgView = PBMessageView()
msgView.showMessage(messageType: .Error, message, view: self, direction: direction)
```

## Getting Started

### Error
Error will display message in Red background
```
let msgView = PBMessageView()
msgView.showMessage(messageType: .Error, message, view: self, direction: direction)
```

### Success
Success will display message in Green background
```
let msgView = PBMessageView()
msgView.showMessage(messageType: .Success, message, view: self, direction: direction)
```

### Warning
Warning will display message in Yellow background
```
let msgView = PBMessageView()
msgView.showMessage(messageType: .Warning, message, view: self, direction: direction)
```
