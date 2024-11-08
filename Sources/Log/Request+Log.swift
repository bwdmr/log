import LogKit
import Vapor
import NIOConcurrencyHelpers



extension Request {
    public var log: Log {
        .init(_application: self)
    }
    
    public struct Log: Sendable {
        public let _request: Request
    }
}


