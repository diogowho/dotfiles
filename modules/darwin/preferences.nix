{
  system.defaults = {
    dock = {
      autohide = true;
      tilesize = 35;
      orientation = "left";
      show-recents = false;
      minimize-to-application = true;
      mru-spaces = false;
      persistent-apps = [
        {
          app = "/nix/store/5f1ghi3sgdpv5m9d8jhi4i3434rqkp7w-zen-beta-1.17.6b/Applications/Zen Browser (Beta).app";
        }
        { app = "/System/Applications/Mail.app"; }
        { app = "/nix/store/cb89wc26l0fzaywsr1y8ds0vwsxi9mr0-ghostty-bin-1.2.3/Applications/Ghostty.app"; }
        { app = "/nix/store/xcwka2yvbvip4lmc1m15gyq99wfwbahn-vesktop-1.6.1/Applications/Vesktop.app"; }
        { app = "/System/Applications/System Settings.app"; }
      ];
    };

    NSGlobalDomain = {
      AppleShowScrollBars = "WhenScrolling";
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticCapitalizationEnabled = false;
      NSScrollAnimationEnabled = true;
    };

    WindowManager = {
      EnableStandardClickToShowDesktop = false;
    };

    screensaver = {
      askForPassword = true;
      askForPasswordDelay = 0;
    };

    finder = {
      ShowPathbar = true;
      FXEnableExtensionChangeWarning = false;
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXRemoveOldTrashItems = true;
      ShowHardDrivesOnDesktop = true;
    };

    CustomUserPreferences."com.apple.finder" = {
      ShowExternalHardDrivesOnDesktop = true;
      ShowHardDrivesOnDesktop = true;
      ShowMountedServersOnDesktop = true;
      ShowRemovableMediaOnDesktop = true;
      _FXSortFoldersFirst = true;
      FXDefaultSearchScope = "SCcf";
      WarnOnEmptyTrash = false;
    };

    loginwindow = {
      GuestEnabled = false;
      SHOWFULLNAME = false;
    };

    controlcenter = {
      BatteryShowPercentage = true;
      Bluetooth = false;
      Display = false;
      FocusModes = false;
      NowPlaying = false;
      Sound = false;
    };
  };

  system.activationScripts.postActivate.text = ''
    #!/usr/bin/env bash
    set -e

    sudo chflags nohidden /Volumes
    chflags nohidden "$HOME/Library"
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder

    killall Dock Finder SystemUIServer WindowManager || true
  '';
}
