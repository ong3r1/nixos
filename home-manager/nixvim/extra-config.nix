{ ... }: {
  extraConfigLua = ''
    require("telescope").load_extension("persisted")
  '';
}
