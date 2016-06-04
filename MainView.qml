import QtQuick 2.5
import QtQuick.Controls 1.4

View {
    id: mainView
    // positioning and resizing the view should probably be handled differently
    // For example you can have a manager that will display a name
    // of the view, some navigation buttons and then below
    // render the view. If making such manager it should be the same
    // for all views.
    anchors.fill: parent

    // we will use this property to nicely position the content
    property double margins: (width + height) / 40

    // Example usage of the life cycle functions.
    onStart: {
        rotationAnimation.start()
    }
    onResume: {
        textEdit.enabled = true
        rotationAnimation.resume()
    }
    onPause: {
        textEdit.enabled = false
        rotationAnimation.pause()
    }

    // message used when user pressess the button
    function sendMessage(messageContent) {
        // An example of creating new view.
        loadView("qrc:/MessageView.qml", [messageContent])
    }

    // Below is the content of the view. There can be anything and
    // can be positioned as you like.
    Text {
        id: welcomeText
        anchors.top: parent.top
        anchors.topMargin: margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - margins * 2
        height: margins * 2
        text: "Hello world!"
        font.pixelSize: height
        font.bold: true
    }

    Text {
        id: instructionText
        anchors.top: welcomeText.bottom
        anchors.topMargin: margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - margins * 2
        height: margins * 4
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "Write something and push the button!"
        font.pixelSize: height * 0.3
    }

    Rectangle {
        id: textEditHighlight
        anchors.fill: textEdit
        color: "#EEE"
    }

    TextEdit  {
        id: textEdit
        anchors.top: instructionText.bottom
        anchors.topMargin: margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width - margins * 2
        height: margins * 2
        font.pixelSize: height * 0.7
        text: "Example message"
    }

    Button {
        id: sendMessageButton
        anchors.top: textEdit.bottom
        anchors.topMargin: margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: (parent.width - margins * 2) / 2
        height: margins * 2
        text: "Send"
        onClicked: {
            sendMessage(textEdit.text)
        }
    }


    // This rectangle will rotate when the view is on top.
    Rectangle {
        anchors.top: sendMessageButton.bottom
        anchors.topMargin: margins
        anchors.horizontalCenter: parent.horizontalCenter
        width: margins * 3
        height: width
        color: "#89E884"

        NumberAnimation on rotation {
            id: rotationAnimation
            running: false
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 4000
        }

        Text {
            anchors.fill: parent
            anchors.margins: parent.width * 0.1
            font.pixelSize: height
            minimumPixelSize: 3
            fontSizeMode: Text.Fit
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "rotating while in active state"
        }
    }

}
