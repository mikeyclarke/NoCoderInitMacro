import SwiftDiagnostics

enum NoCoderInitDiagnostic: DiagnosticMessage {
    case notAClass

    var severity: DiagnosticSeverity {
        return .error
    }

    var message: String {
        switch self {
        case .notAClass:
            "Macro \"@NoCoderInit\" can only be applied to classes."
        }
    }

    var diagnosticID: MessageID {
        return .init(domain: "NoCoderInitMacro", id: self.message)
    }
}
