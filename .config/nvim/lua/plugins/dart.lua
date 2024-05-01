return {
	{ "dart-lang/dart-vim-plugin" }, -- Adds Dart language support
	{
		"thosakwe/vim-flutter", -- Flutter support for Neovim
		build = ":UpdateRemotePlugins", -- Ensures the plugin is properly set up after installation
	},
}
