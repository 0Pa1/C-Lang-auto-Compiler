# C Compiler Script

A simple and interactive shell script that automates the process of compiling C programs. The script allows you to compile a `.c` source file and save the compiled binary in a dedicated `compiled_files` directory. It also provides the option to link with optional libraries, including the math library (`-lm`), pthread library (`-pthread`), OpenSSL (`-lssl`), and zlib (`-lz`).

## Features

- **Easy compilation**: Compile your C programs with a single command.
- **Library linking**: Optionally link libraries such as `-lm`, `-pthread`, `-lssl`, and `-lz` during compilation.
- **Error handling**: Handles invalid or missing source files and provides feedback for common issues.
- **Interactive prompts**: If no library flags are passed, the script prompts you to select libraries interactively.
- **Compiled output**: Compiled programs are saved in a `compiled_files` directory.
- **Verbosity control**: Option to enable verbose mode for detailed output during compilation.
- **Cross-platform**: Works on systems with `bash` and `gcc` installed.

## Usage

### Running the Script

```bash
./compile.sh <source_file.c> [library_flags]
