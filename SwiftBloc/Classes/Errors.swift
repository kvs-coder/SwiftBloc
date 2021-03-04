//
//  Errors.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 04.03.21.
//

import Foundation

/**
 Bloc errors
*/
enum BlocError: Error {
    case noEvent
}
/**
 Cubit (more abstract) errors
*/
enum CubitError: Error {
    case stateNotChanged
}
