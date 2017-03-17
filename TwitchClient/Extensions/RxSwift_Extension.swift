//
//  RxSwift_Extension.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import RxSwift

///  Syntatic sugar for adding a disposable to a bag.
///
/// - Parameters:
///   - bag: DisposeBag to add your disposable to.
///   - disposable: Disposable to put in your bag.
public func += (bag: DisposeBag, disposable: Disposable) {
    disposable.addDisposableTo(bag)
}

/// Syntatic sugar for adding a disposable to a bag from `DisposableObservableProxy`.
/// Use this when you have not finished your chain of subscribes with an `onDisposed`
///
/// - Parameters:
///   - bag: DisposeBag to add your disposable to from a `DisposableObservableProxy`
///   - proxy: `DisposableObservableProxy` holding the disposable you want to add to your bag.
public func += <Value>(bag: DisposeBag, proxy: DisposableObservableProxy<Value>) {
    proxy.add(to: bag)
}

/// This proxy allows for chaining of event subscribers
public class DisposableObservableProxy<Value> {
    public var disposables: [Disposable] = []
    public let observable: Observable<Value>
    public init(_ disposable: Disposable, _ observable: Observable<Value>) {
        self.disposables.append(disposable)
        self.observable = observable
    }
}

public extension Observable {
    func onResult(on scheduler: SchedulerType = MainScheduler.instance, result: OnSuccess<E>?) -> Disposable {
        let single = share()
        return single.observeOn(scheduler).subscribe(onNext: result)
    }
}

public extension Observable {
    func success(on scheduler: SchedulerType = MainScheduler.instance, result: OnSuccess<E>?) -> DisposableObservableProxy<E> {
        let single = share()
        let disposable = single.observeOn(scheduler).subscribe(onNext: result)
        return DisposableObservableProxy(disposable, single)
    }

    func failure(on scheduler: SchedulerType = MainScheduler.instance, onError: OnError<Swift.Error>?) -> DisposableObservableProxy<E> {
        let single = share()
        let disposable = single.observeOn(scheduler).subscribe(onError: onError)
        return DisposableObservableProxy(disposable, single)
    }

    func allSucceeded(on scheduler: SchedulerType = MainScheduler.instance, onCompleted: ((Void) -> Void)?) -> DisposableObservableProxy<E> {
        let single = share()
        let disposable = single.observeOn(scheduler).subscribe(onCompleted: onCompleted)
        return DisposableObservableProxy(disposable, single)
    }

    func always(on scheduler: SchedulerType = MainScheduler.instance, onDisposed: ((Void) -> Void)?) -> Disposable {
        return share().observeOn(scheduler).subscribe(onDisposed: onDisposed)
    }
}

public typealias OnSuccess<Value> = (Value) -> Void
public typealias OnError<Error: Swift.Error> = (Error) -> Void
public extension DisposableObservableProxy {
    func failure(on scheduler: SchedulerType = MainScheduler.instance, onError: OnError<Swift.Error>?) -> DisposableObservableProxy {
        disposables.append(observable.observeOn(scheduler).subscribe(onError: onError))
        return self
    }

    func allSucceeded(on scheduler: SchedulerType = MainScheduler.instance, onCompleted: ((Void) -> Void)?) -> DisposableObservableProxy {
        disposables.append(observable.observeOn(scheduler).subscribe(onCompleted: onCompleted))
        return self
    }

    func always(on scheduler: SchedulerType = MainScheduler.instance, onDisposed: ((Void) -> Void)?) -> DisposableObservableProxy {
        disposables.append(observable.observeOn(scheduler).subscribe(onDisposed: onDisposed))
        return self
    }

    func add(to bag: DisposeBag) {
        for disposable in disposables {
            disposable.addDisposableTo(bag)
        }
    }
}
