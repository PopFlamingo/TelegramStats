// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: TelegramExport.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct TelegramExport {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var name: String = String()

  var type: String = String()

  var id: Int64 = 0

  var messages: [Message] = []

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}
}

struct Message {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var id: Int64 = 0

  var type: String = String()

  var date: String = String()

  var from: String = String()

  var fromID: String = String()

  var text: SwiftProtobuf.Google_Protobuf_Value {
    get {return _text ?? SwiftProtobuf.Google_Protobuf_Value()}
    set {_text = newValue}
  }
  /// Returns true if `text` has been explicitly set.
  var hasText: Bool {return self._text != nil}
  /// Clears the value of `text`. Subsequent reads from it will return its default value.
  mutating func clearText() {self._text = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _text: SwiftProtobuf.Google_Protobuf_Value? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension TelegramExport: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "TelegramExport"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "name"),
    2: .same(proto: "type"),
    3: .same(proto: "id"),
    4: .same(proto: "messages"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.name) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.type) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.id) }()
      case 4: try { try decoder.decodeRepeatedMessageField(value: &self.messages) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.name.isEmpty {
      try visitor.visitSingularStringField(value: self.name, fieldNumber: 1)
    }
    if !self.type.isEmpty {
      try visitor.visitSingularStringField(value: self.type, fieldNumber: 2)
    }
    if self.id != 0 {
      try visitor.visitSingularInt64Field(value: self.id, fieldNumber: 3)
    }
    if !self.messages.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.messages, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: TelegramExport, rhs: TelegramExport) -> Bool {
    if lhs.name != rhs.name {return false}
    if lhs.type != rhs.type {return false}
    if lhs.id != rhs.id {return false}
    if lhs.messages != rhs.messages {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Message: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Message"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "id"),
    2: .same(proto: "type"),
    3: .same(proto: "date"),
    4: .same(proto: "from"),
    5: .unique(proto: "fromID", json: "from_id"),
    6: .same(proto: "text"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.id) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.type) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.date) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.from) }()
      case 5: try { try decoder.decodeSingularStringField(value: &self.fromID) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._text) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.id != 0 {
      try visitor.visitSingularInt64Field(value: self.id, fieldNumber: 1)
    }
    if !self.type.isEmpty {
      try visitor.visitSingularStringField(value: self.type, fieldNumber: 2)
    }
    if !self.date.isEmpty {
      try visitor.visitSingularStringField(value: self.date, fieldNumber: 3)
    }
    if !self.from.isEmpty {
      try visitor.visitSingularStringField(value: self.from, fieldNumber: 4)
    }
    if !self.fromID.isEmpty {
      try visitor.visitSingularStringField(value: self.fromID, fieldNumber: 5)
    }
    try { if let v = self._text {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: Message, rhs: Message) -> Bool {
    if lhs.id != rhs.id {return false}
    if lhs.type != rhs.type {return false}
    if lhs.date != rhs.date {return false}
    if lhs.from != rhs.from {return false}
    if lhs.fromID != rhs.fromID {return false}
    if lhs._text != rhs._text {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
