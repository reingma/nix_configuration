{lib, ...}:
{
	i18n = {
		defaultLocale = lib.mkDefault "en_US.UTF-8";
		extraLocaleSettings = {
    			LC_ADDRESS = lib.mkDefault "da_DK.UTF-8";
    			LC_IDENTIFICATION = lib.mkDefault "da_DK.UTF-8";
    			LC_MEASUREMENT = lib.mkDefault "da_DK.UTF-8";
    			LC_MONETARY = lib.mkDefault "da_DK.UTF-8";
    			LC_NAME = lib.mkDefault "da_DK.UTF-8";
    			LC_NUMERIC = lib.mkDefault "da_DK.UTF-8";
    			LC_PAPER = lib.mkDefault "da_DK.UTF-8";
    			LC_TELEPHONE = lib.mkDefault "da_DK.UTF-8";
    			LC_TIME = lib.mkDefault "da_DK.UTF-8";

 	 	};
	};
	location.provider = "geoclue2";
  	time.timeZone = lib.mkDefault "Europe/Copenhagen";
}
