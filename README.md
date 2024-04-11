# Main Purpose
Logitech provides a PDF that describes the different methods for G HUB.

It's not really all that convenient to use.

So - I used chatgpt to make descriptions (using the direct text from the PDF) to create wrapper methods.

This code wraps the default methods with very little modification, and provides descriptions that can be easily viewed within VS Code via the plugin "Lua" by sumneko.

The methods can be used by using the default method names in the PDF, except started with "i".

# Other Details
It includes some helper methods which help protect you from infinite loops or bugged code. The helper methods can be terminated by holding ctrl+shift at the same time, which will short circuit a script.

There's also a pseudo-class called AppendixA which is a direct match to Appendix A in the PDF. Values accessed via AppendixA.scancodes["f1"] for example.
