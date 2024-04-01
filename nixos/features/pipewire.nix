{lib, config, ...}:
{
	options = {
		pipewire-sound.enable = lib.mkEnableOption "Enable pipewire sound control";
	};
	config = lib.mkIf config.pipewire-sound.enable {
		security.rtkit.enable = true;
		hardware.pulseaudio.enable = false;
		services.pipewire = {
			enable = true;
			alsa.enable = true;
			alsa.support32Bit = true;
			pulse.enable = true;
			jack.enable = true;
		};
	};
}
