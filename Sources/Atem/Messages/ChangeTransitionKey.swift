import Foundation

extension Message.Do {
    struct ChangeTransitionKey: SerializableMessage {
        static let title = "CTKi"

        let mixEffectIndex: UInt8
        let tie: Bool

        func serialize() -> Data {
            var data = Data()
            data.append(mixEffectIndex)
            data.append(tie ? 1 : 0)
            return data
        }
    }
}