import Foundation

extension Message.Do {
    public struct ChangeKeyOnAir: SerializableMessage {
        public static let title = Message.Title(string: "CKOn")

        public let mixEffectIndex: UInt8
        public let upstreamKey: UInt8
        public let onAir: Bool

        public init(mixEffectIndex: UInt8, upstreamKey: UInt8, onAir: Bool) {
            self.mixEffectIndex = mixEffectIndex
            self.upstreamKey = upstreamKey
            self.onAir = onAir
        }

        public var dataBytes: [UInt8] {
            .init(unsafeUninitializedCapacity: 64) { buffer, count in
                buffer[0] = mixEffectIndex
                buffer[1] = upstreamKey
                buffer[2] = onAir ? 1 : 0
                count = 64
            }
        }

        public var debugDescription: String {
            "Change Key OnAir: ME\(mixEffectIndex) Key\(upstreamKey) = \(onAir)"
        }
    }
}
