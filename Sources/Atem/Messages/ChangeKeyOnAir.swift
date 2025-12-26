import Foundation

extension Message.Do {
    struct ChangeKeyOnAir: SerializableMessage {
        static let title = "CKOn"

        let mixEffectIndex: UInt8
        let upstreamKey: UInt8
        let onAir: Bool

        func serialize() -> Data {
            var data = Data()
            data.append(mixEffectIndex)
            data.append(upstreamKey)
            data.append(onAir ? 1 : 0)
            return data
        }
    }
}
