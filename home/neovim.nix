{ pkgs, config, ... }: {
  home.packages = with pkgs; [
    xclip
    gnumake
    ripgrep
    nodejs_22
    deno

    # Formatters
    nixpkgs-fmt
    prettierd
    stylua

    # LSPs
    lua-language-server # lua
    nil # Nix
    vscode-langservers-extracted # JSON / HTML / CSS / ESLint
    nodePackages.typescript-language-server
    nodePackages.intelephense

    # DAPs
    # (writeShellScriptBin "php-debug" "${nodejs_18}/bin/node ${vscode-extensions.xdebug.php-debug}/share/vscode/extensions/xdebug/php-debug/out/extension.js")
  ];

  programs = {
    neovim = {
      enable = true;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  home.file.".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/.config/nvim";
}
