/*
 * Copyright (C) 2015 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 1.1
import com.nokia.meego 1.0
import MusiKloud 2.0
import ".."
import "file:///usr/lib/qt4/imports/com/nokia/meego/UIConstants.js" as UI

MyPage {
    id: root

    title: qsTr("Plugins")
    tools: ToolBarLayout {

        BackToolIcon {}
    }

    ListView {
        id: view

        anchors.fill: parent
        interactive: count > 0
        model: PluginSettingsModel {
            id: pluginModel
        }
        header: PageHeader {
            title: root.title
        }
        delegate: DrillDownDelegate {
            text: name
            onClicked: appWindow.pageStack.push(Qt.resolvedUrl("PluginSettingsPage.qml")).loadSettings(name, value)
        }
        
        Label {
            anchors {
                fill: parent
                margins: UI.PADDING_DOUBLE
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.pixelSize: 60
            color: UI.COLOR_INVERTED_SECONDARY_FOREGROUND
            text: qsTr("No plugins")
            visible: pluginModel.count == 0
        }
    }

    ScrollDecorator {
        flickableItem: view
    }    
}
