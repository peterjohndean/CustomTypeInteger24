#  Custom Type Integer Int24/UInt24

## License
GNU GPLv3 or later.

## Preface
I’m not a computer scientist or a pro programmer, but I’m a hobbyist who loves learning about programming and different techniques. I’m writing this post to share my learning journey with others, and I’d love to hear your thoughts and suggestions. Feel free to give me any feedback you have, and I’ll try to incorporate it into my future posts.

## Objectives
1. To develop a fully interactive custom integer data type in Swift, while simultaneously enhancing my existing knowledge in the field.
2. To progressively enhance the software’s functionality, ultimately leading to our desired outcome.
3. To achieve this goal, I will require assistance. To date, my only coding companion has been ChatGPT and GitHub Copilot.

## Introduction
I will initially creating structured pairs, Int24 and UInt24, leading to a usable library package with the aim to provides some basics like initialise, set, get and provide a description string that will make the values look a little better than the default.

### v0.0.1 - Basics with protocols CustomStringConvertible, ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral
- Initialisers; Int24(), Int24(123), Int24(Int8(-123))
- Literal types; let a: Int24 = 123, let a: Int24 = -3.14159
- Descriptions; Int24().description, String("\(Int24())")

### v0.0.2 - Added protocol Comparable
- The minimum required syntax is to include `==` and `<` operators. 
- These operators, along with `>`, `>=`, `<=`, and `!=`, are automatically included.
- While this syntax enables us to work with literals, it does not allow operands to interact with other data types.
- We will need to include these additional operators in the next version.
