import Foundation

extension Message.Do {
    public struct ChangeTransitionKey: SerializableMessage {
        public static let title = Message.Title(string: "CTTp")

        public let mixEffectIndex: UInt8
        public let tie: Bool

        public init(mixEffectIndex: UInt8, tie: Bool) {
            self.mixEffectIndex = mixEffectIndex
            self.tie = tie
        }

        public var dataBytes: [UInt8] {
            .init(unsafeUninitializedCapacity: 64) { buffer, count in
                buffer[0] = mixEffectIndex
                buffer[1] = tie ? 1 : 0
                count = 64
            }
        }

        public var debugDescription: String {
            "Change Transition Key Tie: ME\(mixEffectIndex) = \(tie)"
        }
    }
}

