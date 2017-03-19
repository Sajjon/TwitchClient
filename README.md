# TwitchClient
This repo fetches top games from Twitch and for a given game it fetches the top streams.

# Requirements
You need a `Client-Id` (API token) to run this project. [Read here about how to retrieve said Client-Id](https://blog.twitch.tv/client-id-required-for-kraken-api-calls-afbb8e95f843#.3tdo0bjn9). Paste this `Client-Id` in the `Environments.plist` file.

# Clean Code
This project uses [SwiftLint](https://github.com/realm/SwiftLint) enforce Swift style and conventions. Open the [swiftlint.yml](.swiftlint.yml) file to see the rules I have setup. One of the most strict rules is that **no file can be longer than 100 lines of code**. If any file exceed this limit the code will not compile.

# Architectural choices
I use some industry standard pods such as Alamofire, ObjectMapper (which I prefer over SwiftyJson thanks to syntax and the new `ImmutableMappable` protocol).

I think writing protocols for all parts of the app **doing stuff**, such as API and HTTPClients make the code more modular. A good way to enforce writing protcols is to use dependency injection. I like to use [Swinject](https://github.com/Swinject/Swinject) for dependency injection (DI). DI gets ruined by Storyboards since we cannot use them together, if we were to use Storyboards we would need to use property injection instead, as done in my other [SwiftIntro project](https://github.com/Sajjon/SwiftIntro). And since I do not like Storyboards or Xibs to begin with I tend to not use Interface Builder at all.

Instead I make use of [Cartography](https://github.com/robb/Cartography) for constructing UI.

For async methods I have started using [RxSwift](https://github.com/ReactiveX/RxSwift) lately. But I did not like the syntax
```swift
loadingView.show()x
gamesService.getGames(Pagination(limit: 5))
.subscribe(onNext: { games in
    self.setupTableSource(with: games)
}, onError: { error in
    log.error("Failed to fetch games, error: \(error)")
}) { 
    self.loadingView.hide()
}.addDisposableTo(bag)
```

So I have written an [extension on RxSwift](TwitchClient/Extensions/RxSwift_Extension.swift) that enables this syntax instead:
```swift
loadingView.show()
bag += gamesService.getGames(Pagination(limit: 5))
.success { games in
    self.setupTableSource(with: games)
}.failure { error in
    log.error("Failed to fetch games, error: \(error)")
}.always {
    self.loadingView.hide()
}
```

I use amazing [SwiftGen](https://github.com/SwiftGen/SwiftGen) for generating enums of my `Localizable.strings` strings.

# Non standard design choices
  1. Renamed `Info.plist` -> `TwitchClient-Info.plist` to more easily find it using `CMD + SHIFT + O` command since the project is using Pods and we have many `Info.plist` files.
  2. Renamed `Supporting Files` -> `SupportingFiles` since it is preferably to not use spaces in folders or file names
  3. Moved `AppDelegate` to `SupportingFiles`

# Improvements
I added a third ViewController that got pushed when selecting a stream for a game. I thought it would be nice to be able to watch the stream. I used the `url` inside the `channel` object of the stream and loaded that in a request inside a WKWebView. But the video would not start. Even though I added `allow arbitrary loads` and background mode video (in _Capabilities_). I also tried using AVPlayerLayer and an AVPlayer to stream it, but that did not work. So I thought maybe there is another endpoint I could use. So I found [this blog post mentioning access token requests](https://www.johannesbader.ch/2014/01/find-video-url-of-twitch-tv-live-streams-or-past-broadcasts/). I tried it out but the loading of the playlist timed out. So let it go, but I would have made the app more fun.
