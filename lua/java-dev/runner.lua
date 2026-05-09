local M = {}
local config = require("java-dev").config

function M.init_project()
  local dir = vim.fn.getcwd()
  vim.fn.mkdir(dir .. "/src/main/java/com/example", "p")
  
  local pom = dir .. "/pom.xml"
  if vim.fn.filereadable(pom) == 0 then
    local content = {
      "<project xmlns=\"http://maven.apache.org/POM/4.0.0\"",
      "         xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"",
      "         xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd\">",
      "    <modelVersion>4.0.0</modelVersion>",
      "    <groupId>com.example</groupId>",
      "    <artifactId>my-app</artifactId>",
      "    <version>1.0-SNAPSHOT</version>",
      "    <properties>",
      "        <maven.compiler.source>17</maven.compiler.source>",
      "        <maven.compiler.target>17</maven.compiler.target>",
      "    </properties>",
      "</project>"
    }
    vim.fn.writefile(content, pom)
  end
  
  local main_java = dir .. "/src/main/java/com/example/Main.java"
  if vim.fn.filereadable(main_java) == 0 then
    vim.fn.writefile({
      "package com.example;",
      "",
      "public class Main {",
      "    public static void main(String[] args) {",
      "        System.out.println(\"Hello from Java!\");",
      "    }",
      "}"
    }, main_java)
  end
  
  vim.notify("Java Maven project initialized!", vim.log.levels.INFO)
end

function M.run()
  local file = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  local dir = vim.fn.getcwd()
  
  if vim.fn.filereadable(dir .. "/pom.xml") == 1 then
    vim.cmd("split | terminal " .. config.maven_cmd .. " compile exec:java -Dexec.mainClass=\"com.example.Main\"")
    vim.cmd("startinsert")
    return
  end
  
  if ext ~= "java" then
    vim.notify("Not a Java file.", vim.log.levels.ERROR)
    return
  end
  
  local class_name = vim.fn.expand("%:t:r")
  local class_dir = vim.fn.expand("%:p:h")
  
  local cmd = string.format("cd %s && %s %s && %s %s", vim.fn.shellescape(class_dir), config.javac_cmd, vim.fn.shellescape(vim.fn.expand("%:t")), config.java_cmd, class_name)
  vim.cmd("split | terminal " .. cmd)
  vim.cmd("startinsert")
end

return M
