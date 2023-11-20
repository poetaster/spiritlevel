/*
  Copyright (C) 2014 - 2022 Bruno Valdrighi Luvizotto
  Copyright (C) 2023 Mark Washeim <blueprint@poetaster.de
  Contact: Mark Washeim <blueprint@poetaster.de>
  All rights reserved.

*/
import QtQuick 2.5
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import QtSensors 5.0
import "pages"
import "utils/localdb.js" as Db

ApplicationWindow
{
    id: app_window
    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    QtObject {
        id:config
        property bool First_use: true
        property string Contrast: "low" // or "high"
        property string Uni_style: "both" // or  X or Y
        property string Style: "regular" // or "unidimensional"
        property real X_cal: 0.0  //x_acel_cal
        property real Y_cal: 0.0  //x_acel_cal
        onFirst_useChanged: changed()
        onContrastChanged: changed()
        onUni_styleChanged: changed()
        onStyleChanged: changed()
        onX_calChanged: changed()
        onY_calChanged: changed()

        signal changed()
    }
    Connections {
        target: app_window
        onChanged: console.log("changed")
    }
    property string contrast: config.Contrast
    /*
    onReleased: {
        Database.setProp('saveFps',String(sliderValue))
        saveFps = sFps.sliderValue
    }
    Component.onCompleted: {
        value = Database.getProp('saveFps')
        if (value < 1 )
            value = 5
        saveFps = value
    }*/
    Component.onCompleted:
    {
        if(!config.First_use)
        {
            config.Contrast = "low";
            config.Style = "regular";
            config.Uni_style = "Both";
            config.First_use = true;
        }
        else
        {
            accel.x_acel_cal = config.X_cal
            accel.y_acel_cal = config.Y_cal
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
            config.X_cal = x_acel_cal
        }
        onY_acel_calChanged:
        {
            config.Y_cal = y_acel_cal
        }
    }
}


