# java-dev.nvim

A Neovim plugin for Java development. Compile, run, decompile and debug Java projects.

## Install with silzy.nvim

```lua
use { "SilpofGames/java-dev.nvim",
  config = function()
    require("java-dev").setup()
  end,
}
use { "mfussenegger/nvim-jdtls" }
```

## Commands

| Command | Description |
|---------|-------------|
| `:JavaInitProject` | Initialize a Maven Java project structure |
| `:JavaRun` | Compile and run the current file or Maven project |
| `:JavaDecompile` | Decompile `.class` bytecode with `javap` |
| `:JavaDebug` | Start a DAP debug session |

## Config options

```lua
require("java-dev").setup({
  java_cmd  = "java",
  javac_cmd = "javac",
  maven_cmd = "mvn",
})
```

## Requirements

- JDK 17+
- Maven (`mvn`) for project mode
- `jdtls` for LSP
