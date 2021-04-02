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
public enum BlocError: Error {
    case noEvent
}
/**
 Cubit (more abstract) errors
*/
public enum CubitError: Error {
    case stateNotChanged
}
