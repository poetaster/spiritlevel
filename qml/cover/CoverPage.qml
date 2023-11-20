/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../elements"

CoverBackground {
    id: cover_background
    onStatusChanged: status == Cover.Active ? accel.acel_ativo = true : accel.acel_ativo = false
    Column {
        anchors.fill: parent
        anchors.topMargin: Theme.paddingSmall

        spacing: Theme.paddingSmall

        Label {
            id: label_measures
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Angles:")
        }

        Item {
            height: label_x.height; width: parent.width

            Row {
                spacing: Theme.paddingLarge
                anchors.horizontalCenter: parent.horizontalCenter
                Label {
                    id: label_x

                    //width: parent.width/2
                    visible: config.style == "regular" || config.uni_style == "Both" || config.uni_style == "X"
                    text: "X: " + (accel.x_acel - accel.x_acel_cal).toFixed(accel.precisao)
                }

                Label {
                    id: label_y

                    //width: parent.width/2
                    visible: config.style == "regular" || config.uni_style == "Both" || config.uni_style == "Y"
                    text: "Y: " + (accel.y_acel - accel.y_acel_cal).toFixed(accel.precisao)
                }
            }
        }
    /*    Image {
            id: image
            //width: 160
            //height: 160
            anchors.horizontalCenter: parent.horizontalCenter
            y: 185
            opacity: 0.3
            source: Qt.resolvedUrl("image://theme/Vatupassi")
        }
    */
        Big_circle {
            visible: config.style == "regular"
            anchors {
                left: parent.left; right: parent.right
                margins: Theme.paddingLarge
            }
        }
        Uni_circle {
            visible: config.style == "unidimensional"
            anchors {
                left: parent.left; right: parent.right
                margins: Theme.paddingLarge
            }
        }
    }

    CoverActionList {
        id: coverAction

        CoverAction {
            iconSource: "image://theme/icon-cover-new"
            onTriggered: {
                accel.x_acel_cal = accel.x_acel
                accel.y_acel_cal = accel.y_acel
            }
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-location"
            onTriggered: {
                accel.x_acel_cal = 0
                accel.y_acel_cal = 0
            }
        }

        /*CoverAction {
            iconSource: "image://theme/icon-cover-pause"
        }*/
    }
}


