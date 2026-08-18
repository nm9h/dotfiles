# VS Code Extensions

Extensions used in my VS Code environment, Enjoy !

## Theme & UI

| Extension        | ID                                | Purpose                              |
| ---------------- | --------------------------------- | ------------------------------------ |
| Catppuccin       | `catppuccin.catppuccin-vsc`       | VS Code theme                        |
| Catppuccin Icons | `catppuccin.catppuccin-vsc-icons` | File and folder icons                |
| Better Comments  | `aaron-bond.better-comments`      | Highlighted and categorized comments |
| Error Lens       | `usernamehw.errorlens`            | Displays errors and warnings inline  |

## Python

| Extension           | ID                             | Purpose                                  |
| ------------------- | ------------------------------ | ---------------------------------------- |
| Python              | `ms-python.python`             | Python language support                  |
| Pylance             | `ms-python.vscode-pylance`     | IntelliSense, type checking and analysis |
| Debugpy             | `ms-python.debugpy`            | Python debugging                         |
| Python Environments | `ms-python.vscode-python-envs` | Python environment management            |

## Jupyter

| Extension         | ID                                    | Purpose                    |
| ----------------- | ------------------------------------- | -------------------------- |
| Jupyter           | `ms-toolsai.jupyter`                  | Jupyter notebook support   |
| Jupyter Keymap    | `ms-toolsai.jupyter-keymap`           | Jupyter keyboard shortcuts |
| Jupyter Renderers | `ms-toolsai.jupyter-renderers`        | Rendering notebook outputs |
| Jupyter Cell Tags | `ms-toolsai.vscode-jupyter-cell-tags` | Jupyter cell tags          |
| Jupyter Slideshow | `ms-toolsai.vscode-jupyter-slideshow` | Jupyter slideshow support  |

## C / C++

| Extension    | ID                       | Purpose                    |
| ------------ | ------------------------ | -------------------------- |
| C/C++        | `ms-vscode.cpptools`     | C and C++ language support |
| C++ DevTools | `ms-vscode.cpp-devtools` | C++ development tools      |
| CMake Tools  | `ms-vscode.cmake-tools`  | CMake project integration  |

## Java

| Extension                 | ID                               | Purpose                                |
| ------------------------- | -------------------------------- | -------------------------------------- |
| Language Support for Java | `redhat.java`                    | Java language support                  |
| Extension Pack for Java   | `vscjava.vscode-java-pack`       | Complete Java development setup        |
| Debugger for Java         | `vscjava.vscode-java-debug`      | Java debugging                         |
| Project Manager for Java  | `vscjava.vscode-java-dependency` | Java project and dependency management |
| Test Runner for Java      | `vscjava.vscode-java-test`       | Java testing                           |
| Maven for Java            | `vscjava.vscode-maven`           | Maven integration                      |
| Gradle for Java           | `vscjava.vscode-gradle`          | Gradle integration                     |

## Web Development

| Extension         | ID                                   | Purpose                         |
| ----------------- | ------------------------------------ | ------------------------------- |
| Live Server       | `ritwickdey.liveserver`              | Local development server        |
| Path Intellisense | `christian-kohler.path-intellisense` | File path autocompletion        |
| Prettier          | `esbenp.prettier-vscode`             | Code formatting                 |
| Prettier ESLint   | `rvest.vs-code-prettier-eslint`      | Prettier and ESLint integration |

## SQL / Databases

| Extension | ID              | Purpose                                 |
| --------- | --------------- | --------------------------------------- |
| SQLTools  | `mtxr.sqltools` | SQL development and database management |

## Git

| Extension | ID                   | Purpose                                    |
| --------- | -------------------- | ------------------------------------------ |
| GitLens   | `eamodio.gitlens`    | Git history, blame and repository insights |
| Git Graph | `mhutchie.git-graph` | Visual Git repository history              |

## Markdown / Documentation

| Extension                 | ID                                    | Purpose                           |
| ------------------------- | ------------------------------------- | --------------------------------- |
| Markdown All in One       | `yzhang.markdown-all-in-one`          | Markdown editing and productivity |
| Markdown Preview Enhanced | `shd101wyy.markdown-preview-enhanced` | Advanced Markdown preview         |

## Spelling

| Extension                   | ID                                             | Purpose                |
| --------------------------- | ---------------------------------------------- | ---------------------- |
| Code Spell Checker          | `streetsidesoftware.code-spell-checker`        | General spell checking |
| Code Spell Checker — Arabic | `streetsidesoftware.code-spell-checker-arabic` | Arabic spell checking  |
| Code Spell Checker — French | `streetsidesoftware.code-spell-checker-french` | French spell checking  |

## Installation

Export the currently installed extensions:

```bash
code --list-extensions > extensions.txt
```

Install extensions from the exported list:

```bash
xargs -L 1 code --install-extension < extensions.txt
```


> [!NOTE]
> **The `extensions.md` file is intended for documentation, while `extensions.txt` can be used for automated restoration of the VS Code environment.**
<p align="left">
