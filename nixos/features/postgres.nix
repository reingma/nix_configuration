{ lib, config, ... }:
{
  options = {
    postgres.enable = lib.mkEnableOption "enable postgres";
  };
  config = lib.mkIf config.postgres.enable { services.postgresql.enable = true; };
}
