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


