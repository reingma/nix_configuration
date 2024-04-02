{ lib, config, ... }: {
  options = {
    no-suspend.enable = lib.mkEnableOption "enable does not suspend";
  };
  config = lib.mkIf config.no-suspend.enable {
    services.xserver.serverFlagsSection =
      "	Option \"StandbyTime\" \"0\"\n	Option \"SuspendTime\" \"0\"\n	Option \"OffTime\" \"0\"\n";
  };
}
