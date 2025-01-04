# C Compiler Script

A simple shell script to compile C programs. It allows you to compile `.c` source files and link optional libraries like `-lm` (math), `-pthread` (pthread), `-lssl` (OpenSSL), and `-lz` (zlib). The compiled program is saved in a `compiled_files` directory.

## Features

- Easily compile C programs.
- Link libraries like `-lm`, `-pthread`, `-lssl`, and `-lz`.
- Interactive prompts for missing input.
- Saves compiled files in a `compiled_files` folder.
- Option for verbose output.
- Add to your PATH for easy access.


## Usage

### Running the Script

```bash
./compile.sh <source_file.c> [library_flags]
./compile.sh hello.c

