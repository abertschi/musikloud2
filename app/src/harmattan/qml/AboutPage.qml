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
import "file:///usr/lib/qt4/imports/com/nokia/meego/UIConstants.js" as UI

MyPage {
    id: root

    title: qsTr("About")
    tools: ToolBarLayout {

        BackToolIcon {}
    }

    Flickable {
        id: flicker

        anchors.fill: parent
        contentHeight: column.height + UI.PADDING_DOUBLE * 2

        Column {
            id: column

            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                margins: UI.PADDING_DOUBLE
            }
            spacing: UI.PADDING_DOUBLE
            
            PageHeader {
                x: -UI.PADDING_DOUBLE
                width: parent.width + UI.PADDING_DOUBLE
                title: root.title
            }

            Image {
                id: icon

                x: parent.width / 2 - width / 2
                source: "file:///usr/share/icons/hicolor/80x80/apps/musikloud2.png"
            }

            Label {
                id: titleLabel

                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
                font.pixelSize: UI.FONT_XLARGE
                color: "white"
                text: "MusiKloud2 " + VERSION_NUMBER
            }

            Label {
                id: aboutLabel

                width: parent.width
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                color: "white"
                text: qsTr("A fully-featured client for SoundCloud that can be extended via plugins.")
                  + "<br><br>&copy; Stuart Howarth 2015"
            }

            Label {
                width: parent.width
                horizontalAlignment: Text.AlignHCenter
                text: qsTr("Contact") + ": <a href='mailto:showarth@marxoft.co.uk?subject=MusiKloud2 " + VERSION_NUMBER
                      + "'>showarth@marxoft.co.uk</a>"
                onLinkActivated: Qt.openUrlExternally(link)
            }
        }
    }

    ScrollDecorator {
        flickableItem: flicker
    }
}
