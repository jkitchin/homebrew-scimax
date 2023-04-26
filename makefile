build:
	HOMEBREW_NO_INSTALL_FROM_API=1 brew install --HEAD --build-from-source --verbose --debug --formula ./Formula/scimax.rb

uninstall:
	brew uninstall scimax


test:
	brew test scimax
