{config, lib, ...}:
{
	options = {
		priting.enable = lib.mkEnableOption "enables printing using CUPS";
	};
	config = lib.mkIf config.printing.enable = {
  		# Enable CUPS to print documents.
  		services.printing.enable = true;
	};
}
