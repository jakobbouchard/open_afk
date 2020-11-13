enum AppList {
  // Browsers
  Chrome,
  Firefox,
  Opera,

  // Utilities
  SevenZip,
  OpenShell,
  WinDirStat,
  Greenshot,
  ShareX,
  JavaRE,

  // Productivity
  AcrobatReader,
  FoxitPDF,
  LibreOffice,
  OpenOffice,

  // Media
  VLC,
  ITunes,
  Spotify,
  Audacity,
  Handbrake,

  // Communication
  Discord,
  Skype,
  Thunderbird,
  MSTeams,
  Zoom,

  // Gaming
  Steam,
  Minecraft,
  Origin,
  Uplay,
  GogGalaxy,
  EpicGames,

  // Art
  PaintDotNet,
  Gimp,
  Blender,

  // Development
  NotepadPP,
  VisualStudio,
  VSCode,
  AndroidStudio,

  // SDK
  Flutter,
  Python,
  JavaDK,
  NodeJS,

  // Remote Access
  MountainDuck,
  Cyberduck,
  WinSCP,
  Filezilla,

  // Security
  AdwCleaner,
  Malwarebytes,
}

extension AppListFunctions on AppList {
  String get packageName => const {
        AppList.Chrome: 'chrome',
        AppList.Firefox: 'firefox',
        AppList.Opera: 'opera',
        AppList.SevenZip: '7zip',
        AppList.VLC: 'vlc',
      }[this];
}
