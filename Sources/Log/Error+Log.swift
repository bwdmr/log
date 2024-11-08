import LogKit
import Vapor



extension LogError: @retroactive AbortError {
    public var status: HTTPResponseStatus {
        .unauthorized
    }
}
