/*
  Copyright (C) 2014 - 2022 Bruno Valdrighi Luvizotto
  Copyright (C) 2023 Mark Washeim <blueprint@poetaster.de
  Contact: Mark Washeim <blueprint@poetaster.de>

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
        property bool first_use: false
        property string contrast: "low" // or "high"
        property string uni_style: "Both" // or  X or Y
        property string style: "regular" // or "unidimensional"
        property real x_cal: 0.0  //x_acel_cal
        property real y_cal: 0.0  //x_acel_cal
        onFirst_useChanged: changed()
        onContrastChanged: changed()
        onUni_styleChanged: changed()
        onStyleChanged: changed()
        onX_calChanged: changed()
        onY_calChanged: changed()

        signal changed()
    }
    Connections {
        target: config
        onChanged: console.log("changed")
    }
    property string contrast: config.contrast
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


