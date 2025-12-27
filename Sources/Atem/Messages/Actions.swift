//
//  Actions.swift
//  Atem
//
//  Clean version for ATEM Mini Pro
//  Prepared for Antonio – 2025
//

import Foundation

// MARK: - CUT (DCut)
extension Message.Do {
    public struct Cut: SerializableMessage {
        public static let title = Message.Title(string: "DCut")
        public let atemSize: AtemSize

        public init(in atemSize: AtemSize) {
            self.atemSize = atemSize
        }

        public init(with bytes: ArraySlice<UInt8>) {
            atemSize = AtemSize(rawValue: bytes.first!)!
        }

        public var dataBytes: [UInt8] {
            [atemSize.rawValue, 0, 0, 0]
        }

        public var debugDescription: String { "CUT" }
    }
}

//////////////////////////////////////////////////////////////
// MARK: - PROGRAM BUS (CPgI)
//////////////////////////////////////////////////////////////

extension Message.Do {
    public struct ChangeProgramBus: SerializableMessage {
        public static let title = Message.Title(string: "CPgI")

        public let mixEffect: UInt8
        public let programBus: VideoSource

        public init(to newProgramBus: VideoSource, mixEffect: UInt8 = 0) {
            self.mixEffect = mixEffect
            self.programBus = newProgramBus
        }

        public init(with bytes: ArraySlice<UInt8>) throws {
            mixEffect = bytes[relative: 0]
            let sourceNumber = UInt16(from: bytes[relative: 2..<4])
            programBus = try VideoSource.decode(from: sourceNumber)
        }

        public var dataBytes: [UInt8] {
            [mixEffect, 0] + programBus.rawValue.bytes
        }

        public var debugDescription: String {
            "Program bus → \(programBus)"
        }
    }
}

//////////////////////////////////////////////////////////////
// MARK: - PREVIEW BUS (CPvI)
//////////////////////////////////////////////////////////////

extension Message.Do {
    public struct ChangePreviewBus: SerializableMessage {
        public static let title = Message.Title(string: "CPvI")

        public let mixEffect: UInt8
        public let previewBus: VideoSource

        public init(to newPreviewBus: VideoSource, mixEffect: UInt8 = 0) {
            self.mixEffect = mixEffect
            previewBus = newPreviewBus
        }

        public init(with bytes: ArraySlice<UInt8>) throws {
            mixEffect = bytes[relative: 0]
            let sourceNumber = UInt16(from: bytes[relative: 2..<4])
            previewBus = try VideoSource.decode(from: sourceNumber)
        }

        public var dataBytes: [UInt8] {
            [mixEffect, 0] + previewBus.rawValue.bytes
        }

        public var debugDescription: String {
            "Preview bus → \(previewBus)"
        }
    }
}

//////////////////////////////////////////////////////////////
// MARK: - CHANGE KEY TYPE (CKTp)
// 0 = Luma, 1 = Chroma, 2 = Pattern, 3 = DVE
//////////////////////////////////////////////////////////////

extension Message.Do {
    public struct ChangeKeyType: SerializableMessage {
        public static let title = Message.Title(string: "CKTp")

        public let mixEffectIndex: UInt8
        public let keyerIndex: UInt8
        public let keyType: UInt8

        public init(mixEffectIndex: UInt8, keyerIndex: UInt8, keyType: UInt8) {
            self.mixEffectIndex = mixEffectIndex
            self.keyerIndex = keyerIndex
            self.keyType = keyType
        }

        public init(with bytes: ArraySlice<UInt8>) throws {
            mixEffectIndex = bytes[relative: 0]
            keyerIndex = bytes[relative: 1]
            keyType = bytes[relative: 2]
        }

        public var dataBytes: [UInt8] {
            [mixEffectIndex, keyerIndex, keyType, 3]
        }

        public var debugDescription: String {
            "Change Key Type → \(keyType)"
        }
    }
}

//////////////////////////////////////////////////////////////
// MARK: - KEY ON AIR (CKOn)
//////////////////////////////////////////////////////////////

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

        public init(with bytes: ArraySlice<UInt8>) throws {
            mixEffectIndex = bytes[relative: 0]
            upstreamKey = bytes[relative: 1]
            onAir = bytes[relative: 2] == 1
        }

        public var dataBytes: [UInt8] {
            [mixEffectIndex, upstreamKey, onAir ? 1 : 0, 0]
        }

        public var debugDescription: String {
            "Key \(upstreamKey) → \(onAir ? "ON" : "OFF")"
        }
    }
}

//////////////////////////////////////////////////////////////
// MARK: - CHANGE TRANSITION TYPE (CTTp)
//////////////////////////////////////////////////////////////

extension Message.Do {
    public struct ChangeTransitionType: SerializableMessage {
        public static let title = Message.Title(string: "CTTp")

        public let mixEffectIndex: UInt8
        public let transitionType: UInt8   // 0=MIX, 1=DIP, 2=WIPE, 3=DVE

        public init(mixEffectIndex: UInt8, transitionType: UInt8) {
            self.mixEffectIndex = mixEffectIndex
            self.transitionType = transitionType
        }

        public init(with bytes: ArraySlice<UInt8>) throws {
            mixEffectIndex = bytes[relative: 0]
            transitionType = bytes[relative: 1]
        }

        public var dataBytes: [UInt8] {
            [mixEffectIndex, transitionType, 0, 0]
        }

        public var debugDescription: String {
            "Transition type → \(transitionType)"
        }
    }
}

//////////////////////////////////////////////////////////////
// MARK: - NEXT TRANSITION ON AIR (TrOn)
//////////////////////////////////////////////////////////////

extension Message.Do {
    public struct ChangeTransitionOnAir: SerializableMessage {
        public static let title = Message.Title(string: "TrOn")

        public let mixEffectIndex: UInt8
        public let onAir: Bool

        public init(mixEffectIndex: UInt8, onAir: Bool) {
            self.mixEffectIndex = mixEffectIndex
            self.onAir = onAir
        }

        public init(with bytes: ArraySlice<UInt8>) throws {
            mixEffectIndex = bytes[relative: 0]
            onAir = bytes[relative: 1] != 0
        }

        public var dataBytes: [UInt8] {
            [mixEffectIndex, onAir ? 1 : 0, 0, 0]
        }

        public var debugDescription: String {
            "Next Transition → \(onAir ? "ON" : "OFF")"
        }
    }
}
