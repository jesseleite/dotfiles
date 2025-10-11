# Dotfiles Guidelines

## General Rules

- Always check existing code patterns before implementing new features
- Follow the established coding style and conventions in each directory
- When unsure about functionality, research documentation before proceeding

## Nvim Config Rules

When working in the `nvim` directory:

- **Verify plugin availability** - Check if the plugin is already installed in the lazy-lock.json file
- **Always check plugin documentation first** - Before planning or making any changes involving plugins, search for and read the plugin's README and official documentation (the latter of which is usually located in the plugin's `doc` directory)
- **Understand existing patterns** - Review similar configurations in the same directory to maintain consistency
- **Follow Neovim conventions** - Use standard Neovim configuration patterns and Lua best practices
