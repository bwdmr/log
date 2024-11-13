import LogKit
import Vapor




extension LogKitError: @retroactive AbortError {
    public var status: HTTPResponseStatus {
        .badRequest
    }
}
