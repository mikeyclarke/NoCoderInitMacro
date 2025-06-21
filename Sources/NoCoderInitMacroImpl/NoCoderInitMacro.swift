import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxMacros

public struct NoCoderInitMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        conformingTo protocols: [TypeSyntax],
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        let accessModifier = try Self.getAccessModifier(from: declaration)

        return [
            """
            \(raw: accessModifier)required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            """
        ]
    }

    private static func getAccessModifier(from declaration: DeclGroupSyntax) throws -> String {
        guard let classdeclaration = declaration.as(ClassDeclSyntax.self) else {
            throw DiagnosticsError(diagnostics: [
                .init(node: Syntax(declaration), message: NoCoderInitDiagnostic.notAClass)
            ])
        }

        guard
            let accessLevel = classdeclaration.modifiers.first(where: \.isNeededAccessLevelModifier)?.name.trimmed
        else {
            return ""
        }

        return "\(accessLevel.text) "
    }
}

extension DeclModifierSyntax {
    var isNeededAccessLevelModifier: Bool {
        switch self.name.tokenKind {
        case .keyword(.public), .keyword(.internal), .keyword(.fileprivate), .keyword(.private):
            return true
        default:
            return false
        }
    }
}
