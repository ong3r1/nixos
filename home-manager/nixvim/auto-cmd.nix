{ ... }: {
  # Force the autoload via an explicit event
  autoCmd = [
    {
      event = [ "VimEnter" ];
      callback = {
        __raw = ''
          function()
            if vim.fn.argc() == 0 then
              require("persisted").load()
            end
          end
        '';
      };
    }
  ];
}
