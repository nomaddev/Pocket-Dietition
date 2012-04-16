
default:
	# Set default make action here
	xcodebuild -target Tests -configuration pocketdietitian -sdk iphonesimulator build	

clean:
	#echo "about to uninstall; delete all under:" 
	#echo "${HOME}/Library/Application Support/iPhone Simulator"
	#-rm -rf "${HOME}/Library/Application Support/iPhone Simulator"
	-rm -rf build/*

test:
	GHUNIT_CLI=1 xcodebuild -target Tests -configuration Debug -sdk iphonesimulator build	

