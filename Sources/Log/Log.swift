import LogKit
import Vapor
import NIOConcurrencyHelpers

extension Request {
    public var log: Log { .init(_request: self) }
    
    public struct Log: Sendable {
        public let _request: Request
        
        //public func log() throws {
        //    guard let service = self._log._request.application.log.service
        //    else { throw Abort(.internalServerError) }
        //
        //    service
        //}
    }
}



extension Application {
    public var log: Log {
        .init(_application: self)
    }
    
    public struct Log: Sendable {
        public let _application: Application
        
        private struct Key: StorageKey, LockKey {
            typealias Value = Storage
        }
        
        public final class Storage: Sendable {
            private struct SendableBox: Sendable {
                var service: LogService?
            }
            
            private let sendableBox: NIOLockedValueBox<SendableBox>
            
            var service: LogService? {
                get {
                    self.sendableBox.withLockedValue { box in
                        box.service
                    }
                }
                
                set {
                    self.sendableBox.withLockedValue { box in
                        box.service = newValue
                    }
                }
            }
            
            init() {
                let box = SendableBox()
                self.sendableBox = .init(box)
            }
        }
        
        init(_application: Application) {
            self._application = _application
        }
        
        
        private(set) var service: LogService? {
            get { self.storage.service }
            nonmutating set { self.storage.service = newValue }
        }
        
        
        private var storage: Storage {
            if let existing = self._application.storage[Key.self] {
                return existing }
            
            else {
                let lock = self._application.locks.lock(for: Key.self)
                lock.lock()
                defer { lock.unlock() }
                
                if let existing = self._application.storage[Key.self] {
                    return existing }
                
                let new = Storage()
                self._application.storage[Key.self] = new
                return new
            }
        }
        
        
        public func make(service: any LogKitServiceable)
        async throws {
            try await self._application.log.service?.register(service)
        }
    }
}
