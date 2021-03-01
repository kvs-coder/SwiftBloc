//
//  Log.swift
//  SwiftBloc
//
//  Created by Kachalov, Victor on 24.08.20.
//

import Foundation

enum Level: String {
    case inf
    case dbg
    case wrg
    case err
}

func logDebug(
    _ message: Any?,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    #if DEBUG
    log(
        message: message,
        level: .dbg,
        file: file,
        line: line,
        function: function
    )
    #endif
}

func logInfo(
    _ message: Any?,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    log(
        message: message,
        level: .inf,
        file: file,
        line: line,
        function: function
    )
}

func logError(
    _ message: Any?,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    log(
        message: message,
        level: .err,
        file: file,
        line: line,
        function: function
    )
}

func logWarning(
    _ message: Any?,
    file: String = #file,
    line: Int = #line,
    function: String = #function
) {
    log(
        message: message,
        level: .wrg,
        file: file,
        line: line,
        function: function
    )
}

private func log(
    message: Any?,
    level: Level,
    file: String,
    line: Int,
    function: String
) {
    let logLevel = level.rawValue.uppercased()
    let logTime = Date()
    let place = (file as NSString).lastPathComponent
    print("[\(logLevel)/\(logTime)]: [\(place):\(line) #\(function)] \(message ?? "")")
}
