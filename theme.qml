import QtQuick
import Rift 1.0
import "layers" as Layers


	FocusScope {
		id: root

	// Show the global Rift footer with light colors to match theme
	property bool footerVisible: true
	property color footerBackgroundColor: "#c5c6c7"
	property color footerTextColor: "#333333"

	// Menu customization (SELECT, START, Settings) - Light ES-DE style
	property color menuBackgroundColor: "#e8e8e8"
	property color menuTextColor: "#333333"
	property color menuAccentColor: "#4a90d9"
	property color menuSecondaryColor: "#f5f5f5"
	property color menuBorderColor: "#cccccc"
	property real menuBackgroundOpacity: 0.98
	property string menuFontFamily: ""

	// When the theme loads, try to restore the last selected game and collection.

	Component.onCompleted: {
		home.currentCollectionIndex = api.memory.get('collectionIndex') || 0;
		software.currentGameIndex = api.memory.get('gameIndex') || 0;
}

	//Calculates screen ratio

	property var screenRatio: root.height < 481 ? 1.98 : 1.88;

	//calculates screen proportion

    property real screenProportion: root.width / root.height;

	//calculates screen aspect

	property var aspectRatio : calculateAspectRatio(screenProportion)

	function calculateAspectRatio(screenProportion){
		if (screenProportion < 1.34){
		return 43;
	}
		return 169;
}

	//Percentage calculator

	function vw(pixel){
		switch (aspectRatio) {
		case 43:
		return vpx(pixel*12.8)
		case 169:
		return vpx(pixel*12.8)
		default:
		return vpx(pixel*12.8)
	}

}


	// Loading the fonts here makes them usable in the rest of the theme

	FontLoader { source: "./assets/fonts/OPENSANS.TTF" }
	FontLoader { source: "./assets/fonts/OPENSANS-LIGHT.TTF" }

	// The actual views are defined in their own QML files. They activate each other by setting the focus.

	Layers.Home {
		id: home
		focus: true

		anchors {
			bottom: parent.bottom
		}

}

	Layers.Software {
		id: software

		anchors {
			top: home.bottom
		}

}

	// I animate the collection view's bottom anchor to move it to the top of the screen. This, in turn, pulls up the details view.

	states: [
		State {
			when: software.focus
		AnchorChanges {
			target: home;
			anchors.bottom: parent.top
		}

	}

]

	// Add some animations.

	transitions: Transition {
		AnchorAnimation {
			duration: 400
			easing.type: Easing.OutQuad
		}

	}

}
