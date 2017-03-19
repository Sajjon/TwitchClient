//
//  Margin.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation

import Cartography

/* You can use either "M4n" or "Margin" */
typealias M4n = Margin
enum Margin: CGFloat {
    case small = 8
    case normal = 16
    case large = 20
    case huge = 40
}

func == (lhs: NumericalEquality, rhs: Margin) -> NSLayoutConstraint {
    return lhs == rhs.rawValue
}

func <= (lhs: NumericalInequality, rhs: Margin) -> NSLayoutConstraint {
    return lhs <= rhs.rawValue
}

func >= (lhs: NumericalInequality, rhs: Margin) -> NSLayoutConstraint {
    return lhs >= rhs.rawValue
}

func + <P: Addition>(lhs: P, rhs: Margin) -> Expression<P> {
    return rhs.rawValue + lhs
}

func + <P: Addition>(lhs: Expression<P>, rhs: Margin) -> Expression<P> {
    return rhs.rawValue + lhs
}

func - <P: Addition>(lhs: P, rhs: Margin) -> Expression<P> {
    return rhs.rawValue - lhs
}

func - <P: Addition>(lhs: Expression<P>, rhs: Margin) -> Expression<P> {
    return rhs.rawValue - lhs
}

func * <P: Multiplication>(lhs: Expression<P>, rhs: Margin) -> Expression<P> {
    return rhs.rawValue * lhs
}

func * <P: Multiplication>(lhs: P, rhs: Margin) -> Expression<P> {
    return rhs.rawValue * lhs
}

func / <P: Multiplication>(lhs: Expression<P>, rhs: Margin) -> Expression<P> {
    return lhs * (1 / rhs.rawValue)
}

func / <P: Multiplication>(lhs: P, rhs: Margin) -> Expression<P> {
    return lhs * (1 / rhs.rawValue)
}
