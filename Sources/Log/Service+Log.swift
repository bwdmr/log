import Vapor



extension LogService {
    @discardableResult
    func register(app: Application, _ service: any LogKitServiceable)
    throws -> Self {
        try self.register(service)
    }
}
