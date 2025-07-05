{ pkgs, ... }:
let
  scripts = import ./scripts/default.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    direnv
  ];

  programs = {
    # zoxide = {
    #   enable = true;
    # };

    direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableBashIntegration = true;
      # enableZshIntegration = true;
    };

    bash.enable = true;

    # zsh = {
    #   enable = true;
    #
    #   shellAliases = {
    #     fc = ". ${scripts.fzf-cd}/bin/fzf-cd .";
    #     fh = ". ${scripts.fzf-cd}/bin/fzf-cd ~";
    #   };
    #
    #   initContent = ''
    #     bindkey '^E' autosuggest-accept
    #     bindkey '^ ' forward-word
    #     source <(${pkgs.fzf}/bin/fzf --zsh)
    #   '';
    #
    #   localVariables = {
    #     ZSH_AUTOSUGGEST_STRATEGY = [
    #       "completion"
    #       "match_prev_cmd"
    #     ];
    #   };
    #
    #   plugins = [
    #     {
    #       name = pkgs.zsh-autosuggestions.pname;
    #       src = pkgs.zsh-autosuggestions.src;
    #     }
    #     {
    #       name = pkgs.zsh-syntax-highlighting.pname;
    #       src = pkgs.zsh-syntax-highlighting.src;
    #     }
    #   ];
    # };
  };
}
