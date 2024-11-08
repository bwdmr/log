import LogKit
import Vapor
import NIOConcurrencyHelpers

@_exported import LogKit



extension Application {
    public var log: Log {
        .init(_application: self)
    }
    
    
    public struct Log: Sendable {
        public let _application: Application
        
        private struct Key: StorageKey {
            typealias Value = Storage
        }
        
        private final class Storage: Sendable {
            private struct SendableBox: Sendable {
                var services: LogService
            }
            
            private let sendableBox: NIOLockedValueBox<SendableBox>
            
            var services: LogService {
                get {
                    self.sendableBox.withLockedValue { box in
                        box.services
                    }
                }
                
                set {
                    self.sendableBox.withLockedValue { box in
                        box.services = newValue
                    }
                }
            }
            
            init() {
                let box = SendableBox(services: .init())
                self.sendableBox = .init(box)
            }
        }
        
        public var services: LogService {
            get { self.storage.services }
            set { self.storage.services = newValue }
        }
        
        private var storage: Storage {
            if let existing = self._application.storage[Key.self] {
                return existing
            } else {
                let new = Storage()
                self._application.storage[Key.self] = new
                return new
            }
        }
    }
}
