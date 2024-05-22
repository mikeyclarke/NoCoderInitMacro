import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
import NoCoderInitMacroImpl

let testMacros: [String: Macro.Type] = [
    "NoCoderInit": NoCoderInitMacro.self,
]

final class NoCoderInitMacroTests: XCTestCase {
    func testMacro() {
        assertMacroExpansion(
            """
            @NoCoderInit
            class ViewController {
                init() {
                }
            }
            """,
            expandedSource: """
            class ViewController {
                init() {
                }

                required init?(coder: NSCoder) {
                    fatalError("init(coder:) has not been implemented")
                }
            }
            """,
            macros: testMacros
        )
    }

    func testMacroUsesAccessControlModifierWhenPresent() {
        assertMacroExpansion(
            """
            @NoCoderInit
            public class ViewController {
                public init() {
                }
            }
            """,
            expandedSource: """
            public class ViewController {
                public init() {
                }

                public required init?(coder: NSCoder) {
                    fatalError("init(coder:) has not been implemented")
                }
            }
            """,
            macros: testMacros
        )
    }

    func testMacroThrowsIfNotAppliedToClass() {
        assertMacroExpansion(
            """
            @NoCoderInit
            struct ViewController {
                init() {
                }
            }
            """,
            expandedSource: """
            struct ViewController {
                init() {
                }
            }
            """,
            diagnostics: [
                .init(message: "Macro \"@NoCoderInit\" can only be applied to classes.", line: 1, column: 1),
            ],
            macros: testMacros
        )
    }
}
