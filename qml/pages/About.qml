import QtQuick 2.0
import Sailfish.Silica 1.0
import "../pages"

Page {
    id: about_page
    anchors.centerIn: parent

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: about_column.height
        contentWidth: parent.width
        Column {
            id: about_column
            spacing: Theme.paddingMedium
            width: parent.width
            PageHeader {
                title: "About"
            }
            Label {
                text: "Vatupassi"
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeHuge
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "0.4.1-1"
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Label {
                text: "Author: Bruno Luvizotto"
                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeMedium
                anchors.horizontalCenter: parent.horizontalCenter
            }
            Row {
                spacing: Theme.paddingSmall
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    height: email_id.height
                    width: height
                    source: "../images/gmail-icon-logo.png"
                }
                Label {
                    id: email_id
                    text: "brunoluvizotto@gmail.com"
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeMedium
                    //anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.color = Theme.highlightColor
                        onReleased: parent.color = Theme.primaryColor
                        onClicked: Qt.openUrlExternally("mailto:brunoluvizotto@gmail.com" +
                                                        "?subject=Vatupassi App and other things :)")
                    }
                }
            }
            Row {
                spacing: Theme.paddingSmall
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    height: email_id.height
                    width: height
                    source: "../images/Twitter-icon-logo.png"
                }
                Label {
                    text: "www.twitter.com/brunoluvizotto"
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeMedium
                    //anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.color = Theme.highlightColor
                        onReleased: parent.color = Theme.primaryColor
                        onClicked: Qt.openUrlExternally("http://www.twitter.com/brunoluvizotto")
                    }
                }
            }
            Row {
                spacing: Theme.paddingSmall
                anchors.horizontalCenter: parent.horizontalCenter
                Image {
                    height: email_id.height
                    width: height
                    source: "../images/linkedin-icon-logo.png"
                }
                Label {
                    text: "Bruno Valdrighi Luvizotto"
                    horizontalAlignment: Text.AlignHCenter
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeMedium
                    //anchors.horizontalCenter: parent.horizontalCenter
                    MouseArea {
                        anchors.fill: parent
                        onPressed: parent.color = Theme.highlightColor
                        onReleased: parent.color = Theme.primaryColor
                        onClicked: Qt.openUrlExternally("http://br.linkedin.com/pub/bruno-valdrighi-luvizotto/27/8ba/4a6/")
                    }
                }
            }
            Image {
                width: parent.width / 4
                height: width / 3
                fillMode: Image.PreserveAspectFit
                source: "../images/btn_donate_LG.gif"
                anchors.horizontalCenter: parent.horizontalCenter
                MouseArea {
                    anchors.fill: parent
                    onClicked: Qt.openUrlExternally("https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=R7ZWGUQTHQRJ4")
                }
            }
        }
    }
}
