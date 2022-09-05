-- Hold default applications to handle more consistent mappings
local defaults = {
	browser = "firefox",
	suspend = "slock systemctl suspend -i",
	work_apps = { slack = "flatpak run com.slack.Slack", thunderbird = "thunderbird" },
}

return defaults
