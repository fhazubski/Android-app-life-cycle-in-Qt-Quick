import QtQuick 2.5
import QtQuick.Controls 1.4

View {
    id: messageView

    // As said in MainView.qml positioning and resizing should be done
    // differently. This is just quick and dirty way.
    anchors.centerIn: parent
    width: parent.width / 2
    height: width / 2
    border.color: "black"

    // This property will help position the objects in the view.
    readonly property string margins: (width + height) / 20

    // This function is called when user presses button.
    function closeWindow() {
        destroyActiveView()
    }


    Text {
        id: messageText
        anchors.fill: parent
        anchors.margins: margins
        anchors.bottomMargin: margins * 3
        font.pixelSize: height * 0.3
        wrapMode: Text.WordWrap
        // An example of how we can read data sent from one view to another
        text: viewData[0]
    }

    Button {
        id: messageButton
        anchors.top: messageText.bottom
        anchors.topMargin: margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - margins * 2
        height: margins
        text: "Okay"
        onClicked: {
            closeWindow();
        }
    }
}
