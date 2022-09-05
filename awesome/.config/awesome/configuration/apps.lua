return {
	-- List of apps to start once on start-up
	run_on_start_up = {
		[[nvidia-settings --assign CurrentMetaMode="nvidia-auto-select +0+0 { ForceFullCompositionPipeline = On }"]],
		"picom -b --dbus",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)", -- credential manager
		"flameshot",
		"steam -silent",
		"blueman-applet",
		-- Add applications that need to be killed between reloads
		-- to avoid multipled instances, inside the awspawn script
		"~/.config/awesome/configuration/awspawn", -- Spawn "dirty" apps that can linger between sessions
		"redshift-gtk",
	},
}
