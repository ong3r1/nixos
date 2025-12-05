{ pkgs, ... }: {
  home.packages = with pkgs; [
    playwright-test
    playwright-browsers
  ];

  home.sessionVariables = {
    PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-browsers}/share/playwright-browsers";
  };
}
