@attached(member, names: named(init(coder:)))
public macro NoCoderInit() = #externalMacro(module: "NoCoderInitMacroImpl", type: "NoCoderInitMacro")
