/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtSensors 5.0
import "pages"

ApplicationWindow
{
    id: app_window
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    property string contrast: config.contrast

    Component.onCompleted:
    {
        if(!config.first_use)
        {
            config.contrast = "low";
            config.style = "regular";
            config.uni_style = "Both";
            config.first_use = true;
        }
        else
        {
            accel.x_acel_cal = config.x_cal
            accel.y_acel_cal = config.y_cal
        }
    }

    Accelerometer {
        id: accel
        active: (Qt.application.active || acel_ativo)

        property bool acel_ativo: true
        property int filter: 6
        property int precisao: 1

        property real x_acel: 0
        property real x_acel_cal: 0
        property real y_acel: 0
        property real y_acel_cal: 0

        onReadingChanged: {
            var aux = (accel.reading.x * 9.174);
            aux = aux > 90 ? 90 : aux
            x_acel = (((filter - 1) * x_acel + aux) / filter).toFixed(precisao)
            aux = (accel.reading.y * 9.174);
            aux = aux > 90 ? 90 : aux
            y_acel = (((filter - 1) * y_acel + aux) / filter).toFixed(precisao)
        }
        onX_acel_calChanged:
        {
            config.x_cal = x_acel_cal
        }
        onY_acel_calChanged:
        {
            config.y_cal = y_acel_cal
        }
    }
}


