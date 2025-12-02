{ config
, pkgs
, lib
, ...
}: {
  # 1. Enable the main Qt module
  qt = {
    enable = true;
    # 2. Tell Qt to use the qtct configuration tool
    platformTheme.name = "qtct";
    # 3. Use the Kvantum theme engine for styling
    style = {
      name = "kvantum";
    };
  };

  # 4. Install Kvantum and the configuration tools as user packages
  home.packages = with pkgs; [
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qt5ct
    qt6ct
  ];

  # 5. Set the icon theme inside the configuration file declaratively (optional but robust)
  xdg.configFile."qt5ct/qt5ct.conf".text = lib.generators.toINI { } {
    Appearance = {
      # This MUST match the name of the installed icon theme package
      icon_theme = "Qogir-Dark";
    };
  };

  # Repeat for qt6ct if you have qt6 apps
  xdg.configFile."qt6ct/qt6ct.conf".text = lib.generators.toINI { } {
    Appearance = {
      icon_theme = "Qogir-Dark";
    };
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_PLATFORMTHEME = "qt5ct";
  };
}
