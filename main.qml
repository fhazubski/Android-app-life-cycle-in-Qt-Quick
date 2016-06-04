// This is were it all starts. Keep in mind that this is an example. Read it,
// understand it and use it however you like.

// View.qml is a template for a view. MainView.qml and MessageView.qml
// inherit this object. View.qml automatically detects changes in the
// OS and informs the view (stops it, resumes etc.)

import QtQuick 2.5
import QtQuick.Window 2.2

Window {
    id: appWindow
    visible: true

    // This list contains all views that are currently created. It is
    // a stack - newest views are on its top.
    // This list does not contain whole views but only a reference to them.
    property var createdViews: []

    // This function executes when application starts
    Component.onCompleted: {
        loadView("qrc:/MainView.qml")
    }


    // Functions and properties in this file are visible and can be used
    // by all children and grand children. It means that our views will be able
    // to call the functions below.

    // Load new view
    // `viewFile` is an url to the qml file.
    // `data` is an array with the data that new view will start with
    //
    // You will probably want to load views differently. That is because
    // my method uses synchronous functions that cause GUI to freeze while
    // loading complicated views.
    // Look here for available alternatives that will make GUI not freeze:
    // http://doc.qt.io/qt-5/qml-qtqml-component.html#incubateObject-method
    // http://doc.qt.io/qt-5/qml-qtquick-loader.html#asynchronous-prop
    function loadView (viewFile, data) {
        // This function creates a Component object from a file
        // Component has function `createObject()` that creates visible
        // object. We will need that.
        var component = Qt.createComponent(viewFile)
        if (component.status === Component.Ready) {
            // If there are already created views pause the most recent one
            if (createdViews.length)
                createdViews[createdViews.length - 1].pause();
            // Create new view. Set its z to the highest value, so it will
            // render at the top and handle data to it.
            // We also need to specify a parent to the object.
            // It will be `appWindow`
            createdViews.push(component.createObject(appWindow,
                                                     {z: createdViews.length,
                                                      viewData: data}))
            // View will call create() as soon as it is created.
            // Because we want this new view to be visible immediately
            // we call start() and resume()
            createdViews[createdViews.length - 1].start()
            createdViews[createdViews.length - 1].resume()
        }
        else
            // Display errors if file was not loaded successfuly
            console.error("Error loading view:", component.errorString())
        // QML handles memory itself. I do not need to destroy Component
        // that I created at the beginning of this function. It will
        // be destroyed automatically when needed.
    }

    // Destroy the view at the top and notify the second top one.
    function destroyActiveView() {
        // Every view has destroyView() function that will do the job for us
        createdViews[createdViews.length - 1].destroyView();
        // After view is destroyed we need to erase last element from
        // createdViews list
        createdViews.splice(createdViews.length - 1, 1);
        // We want to resume current top view.
        if (createdViews.length)
            createdViews[createdViews.length - 1].resume();
    }
}
