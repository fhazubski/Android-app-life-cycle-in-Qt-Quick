import QtQuick 2.0

Rectangle {
    id: view
    color: "white"

    // This property contains current state of the applications.
    // Available states are described here:
    // http://doc.qt.io/qt-5/qml-qtqml-qt.html#application-prop
    // We need to duplicate it to have appStateChanged() signal
    property int appState: Qt.application.state

    // This variable will contain data that view is starting with
    property var viewData

    // When appState changes we need to call proper signals
    onAppStateChanged: {
        if (appState === Qt.ApplicationActive)
            resume();
        else if (appState === Qt.ApplicationInactive)
            pause();
        else { // if (Qt.ApplicationSuspended || Qt.ApplicationHidden)
            pause();
            stop();
        }
    }

    // This is function to destroy a view. Before really destroying it
    // we will call pause(), stop() and destroy() signals.
    // Keep in mind that saving user data asynchronously in these functions
    // will probably fail. View will be destroyed before the function finishes.
    function destroyView() {
        pause();
        stop();
        destroy();
        view.destroy();
    }

    // When view is created call proper signal
    Component.onCompleted: {
        create()
    }

    // When view is being destroyed call proper signals.
    // Yes, destroyView() duplicates the functions but keep in mind
    // that if application is being closed by the OS then
    // this only will be executed, not destroyView().
    Component.onDestruction: {
        pause();
        stop();
        destroy();
    }

    // The Android like signals that we will use to manage view life cycle
    signal create();
    signal start();
    signal resume();
    signal pause();
    signal stop();
    signal destroy();

}
