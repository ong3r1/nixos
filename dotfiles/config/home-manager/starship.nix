{ pkgs, ... }:
{
  programs.starship = {
    enable = true;

    settings = {
      add_newline = false;
      format = "$directory$git_branch$git_status$character";

      directory = {
        truncate_to_repo = false;
      };

      git_branch = {
        # No symbol override = default branch name shown
        format = " on [$branch]($style)";
      };

      git_status = {
        # Just shows counts, no colours
        format = " [$all_status$ahead_behind]($style)";
      };

      golang = {
        format = " [Go $version]($style)";
      };

      python = {
        format = " [Py $version $virtualenv]($style)";
      };

      nodejs = {
        format = " [Node $version]($style)";
        # This will also show up for Next.js projects (which have `package.json` or `.nvmrc`)
      };

      rust = {
        format = " [Rust $version]($style)";
      };

      custom.sql_env = {
        when = "test -f .sqlrc || test -f .env.db";
        format = " [SQL env]($style)";
        shell = [ "sh" ];
      };

      character = {
        success_symbol = "[❯](bold)";
        error_symbol = "[❯](bold red)";
      };
    };
  };
}
