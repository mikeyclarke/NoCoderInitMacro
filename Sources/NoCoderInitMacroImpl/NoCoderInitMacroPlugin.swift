import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct NoCoderInitMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        NoCoderInitMacro.self
    ]
}
