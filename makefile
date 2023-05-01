head:
	HOMEBREW_NO_INSTALL_FROM_API=1 brew install --HEAD --build-from-source --verbose --debug --formula ./Formula/scimax.rb

build:
	HOMEBREW_NO_INSTALL_FROM_API=1 brew install --build-from-source --verbose --debug --formula ./Formula/scimax.rb


brew:
	brew tap jkitchin/scimax
	brew uninstall scimax || true
	brew update
	brew install scimax
	scimax

clean:
	brew uninstall scimax


test:
	brew test scimax
