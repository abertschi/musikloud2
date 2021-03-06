/*
 * Copyright (C) 2015 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "pluginstreammodel.h"
#include "resources.h"

PluginStreamModel::PluginStreamModel(QObject *parent) :
    SelectionModel(parent),
    m_request(new ResourcesRequest(this))
{
    connect(m_request, SIGNAL(serviceChanged()), this, SIGNAL(serviceChanged()));
    connect(m_request, SIGNAL(finished()), this, SLOT(onRequestFinished()));
}

QString PluginStreamModel::service() const {
    return m_request->service();
}

void PluginStreamModel::setService(const QString &s) {
    m_request->setService(s);
}

QString PluginStreamModel::errorString() const {
    return m_request->errorString();
}

ResourcesRequest::Status PluginStreamModel::status() const {
    return m_request->status();
}

void PluginStreamModel::list(const QString &id) {
    if (status() == ResourcesRequest::Loading) {
        return;
    }
    
    clear();
    m_id = id;
    m_request->list(Resources::STREAM, id);
    emit statusChanged(status());
}

void PluginStreamModel::cancel() {
    m_request->cancel();
}

void PluginStreamModel::reload() {
    clear();
    m_request->list(Resources::STREAM, m_id);
    emit statusChanged(status());
}

void PluginStreamModel::onRequestFinished() {
    if (m_request->status() == ResourcesRequest::Ready) {
        foreach (QVariant v, m_request->result().toMap().value("items").toList()) {
            QVariantMap stream = v.toMap();
            append(stream.value("description").toString(), stream);
        }
    }
    
    emit statusChanged(status());
}
