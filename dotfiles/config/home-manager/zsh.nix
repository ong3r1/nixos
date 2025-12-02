{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      zsh-syntax-highlighting
      zsh-autosuggestions
    ];
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    initContent = ''
      # Source syntax highlighting
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

      # Source autosuggestions
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

      cht() {
        local query=$(echo "$@" | sed 's/ /+/g')
        curl "https://cht.sh/$query"
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "z" "sudo" "colored-man-pages" ];
    };
  };
}
