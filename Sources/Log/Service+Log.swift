import LogKit
import Vapor
import NIOConcurrencyHelpers



extension LogService {
    
    @discardableResult
    func register(
        app: Application,
        _ service: any LogKitServiceable
    ) async throws -> Self {
        try await self.register(service)
        
        return self
    }
}
