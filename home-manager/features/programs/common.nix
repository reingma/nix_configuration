{
	config,
	lib,
	pkgs,
	...
}: {
	home.packages = with pkgs; [
		#font
		nerdfonts

		#utils
		neofetch #fetch system info
		nnn #better folder explorer for terminal

		# archives
		zip
		unzip
		p7zip

		#utility
		ripgrep #super grep
		jq #utility for json parsing and prettify
		yq-go #similar to jq but for yaml
		btop #htop replacement
		eza #ls replacement


		#network
		iperf3 #for network measurements
		aria2 #download tool for any type of protocol
		nmap #netowrk discovery and security

		#minsc
		tree #list directory tree structure
		which #gives the path to executables
		file #gives file information
		gnutar #for tar compressing
		gnused #for interacting with text using vi syntax
		zstd #compression tool
		gnupg #cryptography lib
		gawk #interacting with text files
		
		# markdown viewer on terminal
		glow
		
		# monitoring
		btop #process monitoring
		iotop #io monitoring
		iftop #network monitoring

		#sys tools
		sysstat #monitoring system performance
		ethtool #checking on network devices
		pciutils #checking on pci devices
		usbutils #lsusb for checking usb devices

		#ssh
		openssh
		xclip
	];

	programs.fzf = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
	};
	programs.zathura = {
		enable = true;
		options = {
			default-bg = "#${config.colorScheme.palette.base00}";
			default-fg = "#${config.colorScheme.palette.base05}";
		};
	};
}
