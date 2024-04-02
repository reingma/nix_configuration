{ config, lib, ... }: {
  options = {
    printing.enable = lib.mkEnableOption "enables printing using CUPS";
  };
  config = lib.mkIf config.printing.enable {
    # Enable CUPS to print documents.
    services.printing.enable = true;
  };
}
