# dotfiles

Contains various configuration and init scripts that I use for local development

## Additional

- [Dracula](https://draculatheme.com/terminal) Terminal.app theme
- [Oh My Zsh](https://ohmyz.sh)

### Homebrew

| Package                 | Description                              |
| ----------------------- | ---------------------------------------- |
| asdf                    | Version manager for Node, Python, etc... |
| bat                     | Better `cat`                             |
| zsh-syntax-highlighting | Like fsh                                 |
| neovim                  | Vim-fork                                 |
| direnv                  | Dynamic env var loading                  |
| diff-so-fancy           | Better git diff                          |
| the_silver_searcher     | Grep for code search and fzf             |

> `fzf` is installed via vim-plug:
>
> ```sh
> vim
> :PlugInstall
> ```

## Vim shortcuts

| Shortcut                                                        | Description                                        |
| --------------------------------------------------------------- | -------------------------------------------------- |
| <kbd>ZZ</kbd>                                                   | Write current file, if modified, and quit          |
| <kbd>ZQ</kbd>                                                   | Quit without checking for changes                  |
| <kbd>jk</kbd>                                                   | Escape from insert and terminal modes              |
| <kbd>ci'</kbd>                                                  | Change inside single quotes                        |
| <kbd>ci{</kbd>                                                  | Change inside braces                               |
| <kbd>,z</kbd>                                                   | Bring up zsh terminal in split view                |
| <kbd>,p</kbd>                                                   | Run Prettier on buffer                             |
| <kbd>,t</kbd>                                                   | Toggle tree viewer                                 |
| <kbd>,n</kbd>                                                   | Find current file in tree viewer                   |
| <kbd>,f</kbd>                                                   | Ack in all subdirectories                          |
| <kbd>m</kbd>                                                    | While selecting node in tree view to bring up menu |
| <kbd>,,s</kbd>                                                  | Search for character                               |
| <kbd>,,w</kbd>                                                  | Go to word                                         |
| <kbd>,osfu</kbd>                                                | C# find usages                                     |
| <kbd>,osfi</kbd>                                                | C# find implementations                            |
| <kbd>,osca</kbd>                                                | C# code actions                                    |
| <kbd>,os=</kbd>                                                 | C# code format                                     |
| <kbd>,osre</kbd>                                                | C# restart server                                  |
| <kbd>gd</kbd>                                                   | C# go to definition                                |
| <kbd>Ctrl</kbd> + <kbd>p</kbd>                                  | Bring up fuzzy file finder                         |
| <kbd>Ctrl</kbd> + <kbd>b</kbd>                                  | Bring up fuzzy buffer finder                       |
| <kbd>Ctrl</kbd> + <kbd>w</kbd> , <kbd>=</kbd>                   | Resize split evenly                                |
| <kbd>Ctrl</kbd> + <kbd>w</kbd> , <kbd>Ctrl</kbd> + <kbd>r</kbd> | Swap split windows                                 |
| <kbd>:bd</kbd>                                                  | Delete buffer                                      |
