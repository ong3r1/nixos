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

  home.file.".config/qt6ct/qt6ct.conf".enable = false;
  home.file.".config/qt6ct".enable = false;
  home.file.".config/qt5ct/qt5ct.conf".enable = false;
  home.file.".config/qt5ct".enable = false;

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_PLATFORMTHEME = "qt5ct";
  };
}
