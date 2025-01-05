#  Custom Type Integer Int24/UInt24

## License
GNU GPLv3 or later.

## Preface
I’m not a computer scientist or a pro programmer, but I’m a hobbyist who loves learning about programming and different techniques. I’m writing this post to share my learning journey with others, and I’d love to hear your thoughts and suggestions. Feel free to give me any feedback you have, and I’ll try to incorporate it into my future posts.

## Objectives
1. To develop a fully interactive custom integer data type in Swift, while simultaneously enhancing my existing knowledge in the field.
2. To progressively enhance the software’s functionality, ultimately leading to our desired outcome.
3. To achieve this goal, it will require a learning curve. To date, my only coding companions have been ChatGPT and GitHub Copilot.

## Introduction
I will initially creating structured pairs, Int24 and UInt24, leading to a usable library package with the aim to provides some basics like initialise, set, get and provide a description string that will make the values look a little better than the default.

### v0.0.1 - Basics with protocols CustomStringConvertible, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral
- Initialisers; Int24(), Int24(123), Int24(Int8(-123))
- Literal types; let a: Int24 = 123, let a: Int24 = -3.14159
- Descriptions; Int24().description, String("\(Int24())")

### v0.0.2 - Added protocol Comparable
- The minimum required syntax is to include `==` and `<` operators. 
- These operators, along with `>`, `>=`, `<=`, and `!=`, are automatically included.
- Although this syntax facilitates the manipulation of literals, it does not permit operands to interact with other data types. 
- To achieve this, we must adhere to the protocol BinaryInteger.

### v0.0.3 - Added protocol AdditiveArithmetic
- The minimum required was to add the addition (`+`) and subtraction (`-`) operators.
- Additionally, the operators `+=` and `-=` are automatically included, along with the variable zero.

### v0.0.4 - Added protocol Numeric
- The minimum required enhancements were to include the multiplication operators `*` and `*=`, the method `init?(exactly)`, and the variable `magnitude`.

### v0.0.5 - Added protocol BinaryInteger
- Adhering to this protocol proved to be a complex task. I anticipate the necessity of further refinements, as I have already identified several issues.

### v0.0.6 - Added protocol FixedWidthInteger
- Whilst this has been added, it would appear my implementation is now causing circular loops. Now debugging them before releasing 0.0.6
- Found my issues, don't use Self in initialisers, operators, any computed properties or anything that is likely to trigger a circular event.
- Ok, started tidying up the code, moving similar variables, methods into the same files for improved management - that i've learning from finding circular loops.
