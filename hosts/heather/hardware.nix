{
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-uuid/7AE2-203E";
      fsType = "vfat";
    };

    "/" = {
      device = "/dev/sda1";
      fsType = "ext4";
    };
  };

  boot = {
    loader.grub = {
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };

    initrd = {
      availableKernelModules = [
        "ata_piix"
        "uhci_hcd"
        "xen_blkfront"
      ];

      kernelModules = [ "nvme" ];
    };

    tmp.cleanOnBoot = true;
  };

  zramSwap.enable = true;
}
